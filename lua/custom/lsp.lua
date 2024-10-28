local M = {}

local servers = {
  bashls = {},
  lua_ls = {},
  rust_analyzer = {},
  zls = {},
  clangd = {},
  gopls = {},
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == "table" then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

M.setup = function()
  require("neodev").setup({})

  local lspconfig = require("lspconfig")
  local capabilities = vim.tbl_deep_extend(
    "force",
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )

  require("mason").setup()
  local ensure_installed = {
    "stylua",
    "lua_ls",
  }

  vim.list_extend(ensure_installed, servers_to_install)
  require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

  for name, config in pairs(servers) do
    if config == true then
      config = {}
    end
    config = vim.tbl_deep_extend("force", {}, {
      capabilities = capabilities,
    }, config)

    lspconfig[name].setup(config)
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
      local bufnr = args.buf

      local settings = servers[client.name]
      if type(settings) ~= "table" then
        settings = {}
      end

      if client.server_capabilities.completionProvider then
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      end
      if client.server_capabilities.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
      end
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable()
      end
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
      })

      local opts = { buffer = bufnr, silent = true, remap = false }

      vim.keymap.set("n", "gq", require("conform").format, opts)

      vim.keymap.set("n", "gD", "<cmd>Glance type_definitions<CR>", opts)
      vim.keymap.set("n", "gd", "<cmd>Glance definitions<CR>", opts)
      vim.keymap.set("n", "gr", "<cmd>Glance references<CR>", opts)
      vim.keymap.set("n", "gi", "<cmd>Glance implementations<CR>", opts)

      -- code action
      vim.keymap.set("n", "crr", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<a-cr>", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("v", "<a-cr>", vim.lsp.buf.code_action, opts)
      vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)

      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = false })
      end, opts)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = false })
      end, opts)

      -- docs
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<M-p>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("i", "<M-p>", vim.lsp.buf.signature_help, opts)

      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_text = false, float = { border = "single" } })
    end,
  })
end

return M

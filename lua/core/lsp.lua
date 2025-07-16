vim.lsp.enable({
  "tsserver",
  "clangd",
  "lua_ls",
})

vim.diagnostic.config({
  -- virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E ",
      [vim.diagnostic.severity.WARN] = "W ",
      [vim.diagnostic.severity.INFO] = "I ",
      [vim.diagnostic.severity.HINT] = "H ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

--- functions
local function restart(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd("edit")
  end, 100)
end

vim.api.nvim_create_user_command("LspRestart", function()
  restart()
end, {})

local function status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  print("\n")
  print("LSP Status")
  print("\n")

  for i, client in ipairs(clients) do
    print(string.format("Client %d: %s (ID: %d)", i, client.name, client.id))
    print("  Root: " .. (client.config.root_dir or "N/A"))
    print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))
    -- Check capabilities
    local caps = client.server_capabilities

    if caps == nil then
      return
    end

    local features = {}
    if caps.completionProvider then
      table.insert(features, "completion")
    end
    if caps.hoverProvider then
      table.insert(features, "hover")
    end
    if caps.definitionProvider then
      table.insert(features, "definition")
    end
    if caps.referencesProvider then
      table.insert(features, "references")
    end
    if caps.renameProvider then
      table.insert(features, "rename")
    end
    if caps.codeActionProvider then
      table.insert(features, "code_action")
    end
    if caps.documentFormattingProvider then
      table.insert(features, "formatting")
    end

    print("  Features: " .. table.concat(features, ", "))
    print("")
  end
end

vim.api.nvim_create_user_command("LspStatus", function()
  status()
end, {})

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- lua
        lua = { "stylua" },
        -- typescript
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        -- style
        css = { "prettier" },
        scss = { "prettier" },
        -- json
        json = { "jq" },
        jsonc = { "jq" },
        -- shell
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    },
    keys = {
      {
        "gq",
        function()
          require("conform").format()
        end,
        desc = "Format text",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  }, -- end conform
}

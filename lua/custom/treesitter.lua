local M = {}

M.setup = function()
  require("nvim-treesitter").setup()

  vim.keymap.set("n", "<space>tp", ":TSPlaygroundToggle<cr>", { silent = true })
  vim.keymap.set("n", "<space>th", ":Inspect<CR>", { silent = true })
end

return M

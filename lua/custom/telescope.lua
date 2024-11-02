local data = assert(vim.fn.stdpath("data")) --[[@as string]]

require("telescope").setup({
  pickers = {
    find_files = {
      theme = "dropdown",
    },
  },
  extensions = {
    wrap_results = true,

    fzf = {},
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<space>pf", builtin.find_files)
vim.keymap.set("n", "<space>pg", builtin.git_files)
vim.keymap.set("n", "<space>ph", builtin.help_tags)
vim.keymap.set("n", "<space>ps", builtin.live_grep)
vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find)

vim.keymap.set("n", "<space>gw", builtin.grep_string)

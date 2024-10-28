return {
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        styles = {               -- Style to be applied to different syntax groups
          comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          keywords = "NONE",
          numbers = "NONE",
          operators = "NONE",
          strings = "NONE",
          types = "bold",
          variables = "NONE",
        },
        modules = {
          diagnostic = {
            background = false,
          },
        },
      },
    },
    init = function()
      vim.cmd([[colorscheme dawnfox]])
    end,
  },
  -- lazy
}

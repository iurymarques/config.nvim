return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependecies = {
    { "nvim-tree/nvim-web-devicons", lazy = true },
  },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = false,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {
          "diff",
          {
            "diagnostics",
            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
          },
        },
        lualine_y = {
          "branch",
        },
        lualine_z = {},
      },
    })
  end,
}

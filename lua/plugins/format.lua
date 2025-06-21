return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" }
			}
		},
		keys = {
			{ "gq", function() require("conform").format() end, desc = "Format text" }
		}
	}
}

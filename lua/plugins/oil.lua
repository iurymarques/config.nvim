return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		lazy = false,
		keys = {
			{ "<space>pv", "<cmd>Oil<cr>", desc = "Open file explorer" },
		}
	}
}

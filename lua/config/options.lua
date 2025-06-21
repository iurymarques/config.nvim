local opt = vim.opt
local g = vim.g

g.mapleader = ","
g.maplocalleader = " "

-- you have to turn this one on :)
opt.inccommand = "split"

-- best search settings :)
opt.smartcase = true
opt.ignorecase = true

----- personal preferences -----
opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.swapfile = false

opt.wrap = true
opt.linebreak = true

opt.tabstop = 2
opt.shiftwidth = 2

opt.more = false

opt.foldmethod = "manual"

opt.undofile = true

opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = '*',
	callback = function()
		-- don't have `o` add a comment
		opt.formatoptions:remove("o")
	end
})

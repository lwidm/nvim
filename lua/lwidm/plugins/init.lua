-- lua/lwidm/plugins/init.lua

local enabled = true
local plugin = {

	{ "nvim-lua/plenary.nvim" },

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- show undo history using :UndotreeToggle
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	-- nvim-web-devicons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{ "preservim/tagbar" },

	-- vim-visual-multi
	{ "mg979/vim-visual-multi" },
}
if enabled then
	return plugin
else
	return {}
end

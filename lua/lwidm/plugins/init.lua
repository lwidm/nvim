-- lua/lwidm/plugins/init.lua

if true then return {

	{ "nvim-lua/plenary.nvim" },

	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	-- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- Use :Git for git commands in neovim
	"tpope/vim-fugitive",

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
else
	return {}
end

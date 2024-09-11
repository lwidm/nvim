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

	-- figet
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = { window = { winblend = 0 } },
			})
		end,
	},

	-- vim filetype support for the new eww configuration language yuck
	{ "elkowar/yuck.vim" },

	-- show colors in the editor
	{ "brenoprata10/nvim-highlight-colors",
		config = function()
			vim.opt.termguicolors = true

			require("nvim-highlight-colors").setup({})
		end
	},

}
if enabled then
	return plugin
else
	return {}
end

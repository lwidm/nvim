-- lua/lwidm/plugins/nvim-tree.lua

return {
	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				view = {
					side = "left",
				},
			})
			vim.api.nvim_set_keymap(
				"n",
				"<Leader>n",
				":NvimTreeToggle<CR>",
				{ noremap = true, silent = true, desc = "Toggle [N]vimTree" }
			)
		end,
	},
}

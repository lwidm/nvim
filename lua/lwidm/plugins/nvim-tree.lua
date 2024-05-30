-- lua/lwidm/plugins/nvim-tree.lua

local enabled = true
local plugin = {
	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local treeapi = require("nvim-tree.api")
			require("nvim-tree").setup({
				view = {
					side = "left",
				},
			})
			vim.keymap.set(
				"n",
				"<Leader>n",
				":NvimTreeToggle<CR>",
				{ noremap = true, silent = true, desc = "Toggle [N]vimTree" }
			)
			vim.keymap.set(
				"n",
				"<leader>o",
				treeapi.tree.change_root_to_node,
				{ desc = "[O]pen folder and change root to it" }
			)
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

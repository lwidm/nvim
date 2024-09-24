-- lua/lwidm/plugins/nvim-tree.lua

local enabled = true
local plugin = {
	-- nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		-- dependencies = {
		-- 	{ "nvim-tree/nvim-web-devicons", lazy = false },
		-- },
		config = function()
			local devicons = require("nvim-web-devicons")
			-- local fortran_icon, fortran_colour = devicons.get_icon_colors_by_filetype("lua")
			local fortran_icon, fortran_colour = devicons.get_icon_colors_by_filetype("fortran")
			devicons.setup({
				strict = true,
				override_by_extension = {
					["f"] = {
						icon = fortran_icon,
						color = "#FFD700",
						name = "fortran77",
					},
					["f90"] = {
						icon = fortran_icon,
						color = fortran_colour,
						name = "fortran90",
					},
				},
			})
			local treeapi = require("nvim-tree.api")
			require("nvim-tree").setup({
				view = { side = "left" },
			})
			-- stylua: ignore start
			vim.keymap.set( "n", "<Leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle [N]vimTree" } )
			vim.keymap.set( "n", "<leader>o", treeapi.tree.change_root_to_node, { desc = "[O]pen folder and change root to it" } )
			-- stylua: ignore end
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

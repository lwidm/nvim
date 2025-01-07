-- lua/lwidm/plugins/oil.lua

local enabled = true
local plugin = {
	{
		"stevearc/oil.nvim",
		dependecies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				column = { "icon" },
				keympas = {
					["<C-h>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
				},

				vim.keymap.set("n", "<leader>n", "<CMD>Oil<CR>", { desc = "Open parent direcotry" }),
				-- vim.keymap.set("n", "<C-n>", require("oil").toggle_float, { desc = "Open parent direcotry" })
			})
		end,
	},
}

if enabled then
	return plugin
else
	return {}
end

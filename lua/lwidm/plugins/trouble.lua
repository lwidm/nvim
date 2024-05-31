-- lua/lwidm/plugins/trouble.lua

local enabled = true
local plugin = {
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("trouble").setup({
				icons = false,
			})

			vim.keymap.set("n", "<leader>tt", function()
				require("trouble").toggle()
			end, { desc = "[t]oggle the [t]rouble" })
			-- NOTE : maybe I should use <C-n> and <C-p>
			vim.keymap.set("n", "<leader>tn", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end, { desc = "[t]rouble [n]ext" })
			vim.keymap.set("n", "<leader>tp", function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end, { desc = "[t]rouble [p]revious" })
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

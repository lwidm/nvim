-- lua/lwidm/lukas/plugins/gitsigns.lua

if true then
	return {
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup({
					signs = {
						add = { text = "+" },
						change = { text = "~" },
						delete = { text = "_" },
						topdelete = { text = "‾" },
						changedelete = { text = "~" },
					},
				})

				vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "[G]it [P]eview hunk" })
				vim.keymap.set(
					"n",
					"<leader>gt",
					":Gitsigns toggle_current_line_blame<CR>",
					{ desc = "[G]it [T]oggle current line blame" }
				)
			end,
		},
	}
else
	return {}
end

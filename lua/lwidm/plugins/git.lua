-- lua/lwidm/lukas/plugins/git.lua

local enabled = true
local plugin = {

	-- Use :Git for git commands in neovim
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gds", ":Gvdiffsplit!<CR>", { desc = "[G]it vertical [D]iff [S]plit" })
			vim.keymap.set("n", "<leader>gdg2", ":diffget //2<CR>", { desc = "([G]it) [D]iff [G]et //2 (i.e. target)" })
			vim.keymap.set(
				"n",
				"<leader>gdg3",
				":diffget //3<CR>",
				{ desc = "([G]it) [D]iff [G]et //3 (i.e. feature)" }
			)
			vim.keymap.set("n", "<leader>gdp1", ":diffput //1<CR>", { desc = "([G]it) [D]iff [P]ut //1" })
		end,
	},

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
if enabled then
	return plugin
else
	return {}
end

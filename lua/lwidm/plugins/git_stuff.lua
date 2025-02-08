-- lua/lwidm/lukas/plugins/git.lua

local enabled = true
local plugin = {

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"echasnovski/mini.pick", -- optional
		},
		config = function()
			vim.keymap.set("n", "<leader>gn", ":Neogit kind=floating<CR>", { desc = "[G]it status using [N]eogit" })
		end,
	},

	-- Use :Git for git commands in neovim
	{
		"tpope/vim-fugitive",
		config = function()
			-- stylua: ignore start
			vim.keymap.set( "n", "<leader>gds", ":Gvdiffsplit!<CR>", { desc = "[G]it vertical [D]iff [S]plit" } )
			vim.keymap.set( "n", "<leader>gdg2", ":diffget //2<CR>", { desc = "([G]it) [D]iff [G]et //2 (i.e. target)" } )
			vim.keymap.set( "n", "<leader>gdg3", ":diffget //3<CR>", { desc = "([G]it) [D]iff [G]et //3 (i.e. feature)" } )
			vim.keymap.set( "n", "<leader>gdp1", ":diffput //1<CR>", { desc = "([G]it) [D]iff [P]ut //1" } )
			vim.keymap.set( "n", "<leader>gw", ":Gwrite<CR>", { desc = "[G]it [W]rite (add file in current buffer)" } )
			-- stylua: ignore end
		end,
	},

	-- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gs = require("gitsigns")
			gs.setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})

			-- stylua: ignore start
			vim.keymap.set("n", "]c", function()
				if vim.wo.diff then return "]c" end
				vim.schedule(function() gs.next_hunk() end)
				return "<Ignore>"
			end, { expr = true, desc = "go to next hunk (git changes)" })
			vim.keymap.set("n", "[c", function()
				if vim.wo.diff then return "[c" end
				vim.schedule(function() gs.prev_hunk() end)
				vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "[G]it [P]eview hunk" })
				return "<Ignore>"
			end, { expr = true, desc = "go to previous hunk (git changes)" })

			-- Actions
			vim.keymap.set( { "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [S]tage hunk" })
			vim.keymap.set( "n", "<leader>gu", gs.undo_stage_hunk, { desc = "[G]it [U]ndo stage hunk" })
			vim.keymap.set( "n", "<leader>gS", gs.stage_buffer, { desc = "[G]it [S]tage buffer" })
			vim.keymap.set( { "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "[G]it [R]eset hunk" })
			vim.keymap.set( "n", "<leader>gR", gs.reset_buffer, { desc = "[G]it [R]eset buffer" })
			vim.keymap.set( "n", "<leader>gp", gs.preview_hunk, { desc = "[G]it [p]review hunk" })
			vim.keymap.set( "n", "<leader>gt", gs.toggle_current_line_blame, { desc = "[G]it [T]oggle current line blame" } )

			-- Text object
			vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			-- stylua: ignore end
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

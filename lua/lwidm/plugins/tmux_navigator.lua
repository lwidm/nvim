-- lua/lwidm/plugins/tmux_navigator

local enabled = true
local plugin = {
	{
		"christoomey/vim-tmux-navigator",
		opts = {},
		event = "VeryLazy",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", mode = "n" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", mode = "n" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", mode = "n" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", mode = "n" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", mode = "n" },
		},
		--		keys = {
		--			{'n', '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', { desc = 'Move focus to the left window' } },
		--			{'n', '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>', { desc = 'Move focus to the lower window' } },
		--			{'n', '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>', { desc = 'Move focus to the upper window' } },
		--			{'n', '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>', { desc = 'Move focus to the right window' } },
		--			{'n', '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>', { desc = 'Move focus to the next window' } },
		--		},
		config = function()
			vim.g.tmux_navigation = true
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

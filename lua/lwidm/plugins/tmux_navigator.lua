-- lua/lwidm/plugins/tmux_navigator

if true then return {
	{ 'christoomey/vim-tmux-navigator', opts = {}, 
		event = 'Lazy',
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{'n', '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
			{'n', '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
			{'n', '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
			{'n', '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
			{'n', '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
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
		end
	},
}
else
	return {}
end

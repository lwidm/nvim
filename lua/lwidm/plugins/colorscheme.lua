return {
	{ -- colorscheme
		'catppuccin/nvim', name='catppuccin', priority=1000,
		init = function()
			require('catppuccin').setup({
				flavour = 'mocha',
			})
			vim.cmd.colorscheme 'catppuccin'
		end
	},
}

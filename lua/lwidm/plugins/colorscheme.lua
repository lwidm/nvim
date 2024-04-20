return {
	{ -- colorscheme
		'catppuccin/nvim', name='catppuccin', priority=1000,
		init = function()
			local mocha = require("catppuccin.palettes").get_palette("mocha")
			require('catppuccin').setup({
				flavour = 'auto',
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true,
				custom_hightlights = function(mocha)
					return {
						Comment = { fg = colors.flamingo, bg = colors.overlay0 },
					}
				end,
				-- TODO: Test comment
				highlight_overrides = {
					all = function(mocha)
						return {
							NvimTreeNormal = { bg = mocha.none },
						}
					end,
				},
			})
			vim.cmd.colorscheme 'catppuccin'
		end
	},
}

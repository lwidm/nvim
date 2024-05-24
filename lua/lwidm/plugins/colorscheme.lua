local isTransparent = false
if os.getenv("MYSYSTEM") == "Laptop" or os.getenv("MYSYSTEM") == "Desktop" then
	isTransparent = true
end
return {
	{ -- colorscheme
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			local mocha = require("catppuccin.palettes").get_palette("mocha")
			require("catppuccin").setup({
				flavour = "auto",
				background = {
					light = "latte",
					-- dark = "macchiato",
					dark = "mocha",
				},
				transparent_background = isTransparent,
				highlight_overrides = {
					all = function(mocha)
						return {
							NvimTreeNormal = { bg = mocha.none },
						}
					end,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}

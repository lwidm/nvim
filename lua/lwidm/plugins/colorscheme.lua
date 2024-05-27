local isTransparent = false
local transparent_systems = {
	"Laptop",
	"Desktop",
	"wslDesktop",
	"winDesktop",
	"Maerz",
}
local current_system = os.getenv("MYSYSTEM")

for _, system in ipairs(transparent_systems) do
	if system == current_system then
		isTransparent = true
		break
	end
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

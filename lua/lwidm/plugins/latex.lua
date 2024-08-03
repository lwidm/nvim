-- lua/lwidm/plugins/latex.lua

local enabled = true
local plugin = {
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"

			vim.g.maplocalleader = ","
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

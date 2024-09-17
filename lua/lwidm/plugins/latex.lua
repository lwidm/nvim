-- lua/lwidm/plugins/latex.lua

local enabled = true
local plugin = {
	{
		"lervag/vimtex",
		event = "VimEnter",
		init = function()
			if vim.g.os_name == "Windows" then
				vim.g.vimtex_view_general_viewer = "SumatraPDF"
			elseif vim.g.os_name == "Linux" then
				vim.g.vimtex_view_method = "zathura"
			end

			vim.g.maplocalleader = ","
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

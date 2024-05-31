-- lua/lwidm/plugins/snippets.lua

local enabled = true
local plugin = {
	-- Add snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			-- friendly-snippets - enable standardized comments snippets
			require("luasnip").filetype_extend("typescript", { "tsdoc" })
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

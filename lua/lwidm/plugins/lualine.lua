-- lua/lwidm/plugins/lualine.lua

local enabled = true
local plugin = {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					section_separators = "",
					component_separators = "",
				},
			})
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

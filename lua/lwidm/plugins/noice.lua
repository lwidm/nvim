-- lua/lwidm/plugins/noice.lua

local enabled = true
local plugin = {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			background_color = "#00000000",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
if enabled then
	return plugin
else
	return {}
end

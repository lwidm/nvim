-- lua/lwidm/plugins/noice.lua

local enabled = false
local plugin = {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				views = { mini = { win_options = { winblend = 0 } } },
			})
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
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

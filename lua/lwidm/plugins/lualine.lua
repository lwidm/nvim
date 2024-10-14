-- lua/lwidm/plugins/lualine.lua

local enabled = true
local plugin = {
	{
		"chrisgrieser/nvim-recorder",
		dependencies = "rcarriga/nvim-notify", -- optional
		opts = {}, -- required even with default settings, since it calls `setup()`
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { { "nvim-tree/nvim-web-devicons", "chrisgrieser/nvim-recorder", lazy = false } },
		config = function()
			require("lualine").setup({
				options = {
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_y = {
						{ require("recorder").displaySlots },
					},
					lualine_z = {
						{ require("recorder").recordingStatus },
					},
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

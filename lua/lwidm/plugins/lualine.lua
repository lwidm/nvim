-- lua/lwidm/plugins/lualine.lua

local enabled = true
local plugin = {
	-- {
	-- 	"chrisgrieser/nvim-recorder",
	-- 	dependencies = "rcarriga/nvim-notify", -- optional
	-- 	opts = {}, -- required even with default settings, since it calls `setup()`
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			-- "chrisgrieser/nvim-recorder",
		},
		lazy = false,
		config = function()
			local function macro_recording()
				local recording_register = vim.fn.reg_recording()
				if recording_register == "" then
					return ""
				else
					return "Recording @ " .. recording_register
				end
			end
			require("lualine").setup({
				options = {
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_c = { "filename", macro_recording },
				},
				-- sections = {
				-- lualine_y = {
				-- 	{ require("recorder").displaySlots },
				-- },
				-- lualine_z = {
				-- 	{ require("recorder").recordingStatus },
				-- },
				-- },
			})
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

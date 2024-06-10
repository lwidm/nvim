-- lua/lwidm/plugins/neozoom.lua
--
local enabled = true
local plugin = {
	-- neozoom
	{
		"nyngwang/NeoZoom.lua",
		config = function()
			require("neo-zoom").setup({})
		end,
		keys = {
			{
				"<C-w>o",
				function()
					vim.cmd("NeoZoomToggle")
				end,
				mode = "n",
				desc = "Toggle neozoom",
			},
		},
	},
}
if enabled then
	return plugin
else
	return {}
end

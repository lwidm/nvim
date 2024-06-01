-- lua/lwidm/plugins/lsp_noMason.lua

local enabled = true
local for_systems = { "wslDesktop", "wslLaptop", "wslMaerz", "Desktop", "Laptop" }

local plugin = {

	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").pyright.setup({})
		end,
	},
}

local use_for_system = false
for system in pairs(for_systems) do
	if system == os.getenv("MYSYSTEM") then
		use_for_system = true
	end
end
if enabled and use_for_system then
	return plugin
else
	return {}
end

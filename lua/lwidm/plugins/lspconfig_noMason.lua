-- lua/lwidm/plugins/lsp_noMason.lua

local enabled = true
local for_systems = { "wslNixDesktop", "wslNixLaptop", "wslNixMaerz", "NixDesktop", "NixLaptop" }

local plugin = {

	{ "folke/neodev.nvim", opts = {} },

	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"folke/neodev.nvim",
		},
		config = function()
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local serverlist = require("lwidm.lsp_serverlist")

			for server_name, options in pairs(serverlist.lsp_servers) do
				if vim.fn.executable(options[1]) == 1 then
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities =
						vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
					options[2].capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, options[2].capabilities or {})
					options[2].flags = { debounce_text_changes = 150, timeout = 5000 }

					-- Use vim.lsp.config() instead of lspconfig.setup()
					vim.lsp.config(server_name, options[2])
					vim.lsp.enable(server_name)
				end
			end
		end,
	},
}

local use_for_system = false
for _, system in pairs(for_systems) do
	if system == os.getenv("MYSYSTEM") then
		use_for_system = true
	end
end
if enabled and use_for_system then
	return plugin
else
	return {}
end

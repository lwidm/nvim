-- lua/lwidm/plugins/lsp_noMason.lua

local enabled = true
local for_systems = { "wslDesktop", "wslLaptop", "wslMaerz", "Desktop", "Laptop" }

local plugin = {

	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		config = function()
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local serverlist = require("lwidm.lsp_serverlist")
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			for server, options in pairs(serverlist.lsp_servers) do
				if vim.fn.executable(options[1]) == 1 then
					-- local tprint = require("lwidm.helpers").tprint
					-- vim.notify(server .. " options: " .. tprint(options[2]), vim.log.levels.INFO)
					local server_capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, options[2].capabilities or {})
					options[2].capabilities = server_capabilities
					-- vim.notify(server .. " options: " .. tprint(options[2]), vim.log.levels.INFO)
					require("lspconfig")[server].setup(options[2])
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

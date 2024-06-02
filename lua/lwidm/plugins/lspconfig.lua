-- lua/lwidm/plugins/lspconfig.lua

local enabled = true
local not_for_systems = { "wslDesktop", "wslLaptop", "wslMaerz", "Desktop", "Laptop" }

local plugin = {

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
		},

		config = function()
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local lsp_serverlist = require("lwidm.lsp_serverlist")
			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = lsp_serverlist.ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local is_lspserver = false
						for server, _ in pairs(lsp_serverlist.lsp_servers) do
							if server_name == server then
								is_lspserver = true
							end
						end
						if is_lspserver then
							local options = lsp_serverlist.lsp_servers[server_name] or {}
							options[2].capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, options[2].capabilities or {})
							require("lspconfig")[server_name].setup({ options[2] })
						end
					end,
					-- ['rust_analyzer'] = function ()
					-- 	require('rust_tools').setup {}
					-- end,
				},
			})
		end,
	},
}
for _, system in pairs(not_for_systems) do
	if system == os.getenv("MYSYSTEM") then
		enabled = false
	end
end
if enabled then
	return plugin
else
	return {}
end

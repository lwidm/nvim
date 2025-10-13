-- lua/lwidm/plugins/lspconfig.lua

local enabled = true
local not_for_systems = { "wslNixDesktop", "wslNixLaptop", "wslNixMaerz", "NixDesktop", "NixLaptop" }

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
				vim.diagnostic.config({
					signs = {
						active = {
							[hl] = { text = icon, texthl = hl, numhl = hl },
						},
					},
				})
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local lsp_serverlist = require("lwidm.lsp_serverlist")
			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = lsp_serverlist.ensure_installed })

			-- Configure each server explicitly
			for server_name, config in pairs(lsp_serverlist.lsp_servers) do
				local opts = vim.tbl_deep_extend("force", {}, config[2] or {})
				opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
				opts.flags =
					vim.tbl_deep_extend("force", { debounce_text_changes = 150, timeout = 5000 }, opts.flags or {})

				require("lspconfig")[server_name].setup(opts)
			end
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

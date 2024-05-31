-- lua/lwidm/plugins/lsp.lua

local enabled = true
local plugin = {

	-- figet
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = { window = { winblend = 0 } },
			})
		end,
	},

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
			local servers = {
				clangd = {}, -- c, cpp
				codelldb = {}, -- c, cpp debugger
				rust_analyzer = {}, -- rust
				lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } }, -- lua
				cmakelang = {}, -- cmake
				pyright = {}, -- python
				debugpy = {}, -- python debugging
				-- jsonls = {}, -- json
				-- web
				-- html = {}, -- html
				-- cssls = {}, -- css
				-- tsserver = {}, -- javascript, typescript
				-- intelephense = {}, -- php
			}
			local format_servers = {
				"stylua", -- lua
				"clang-format", -- c and c++
				"black", -- python
			}
			local other_tools = {
				"mypy", -- python: static typing
				"ruff", -- python: linter and formatter
			}

			if vim.g.os_name == "Linux" then
				vim.list_extend(servers, {
					nil_ls = {}, -- nix
				})
				vim.list_extend(format_servers, {
					"nixpkgs-fmt", -- NixOs
				})
			end

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, format_servers)
			vim.list_extend(ensure_installed, other_tools)
			require("mason").setup()
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup({})
					end,
					-- ['rust_analyzer'] = function ()
					-- 	require('rust_tools').setup {}
					-- end,
				},
			})
		end,
	},

	-- null_ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.mypy,
					null_ls.builtins.diagnostics.ruff,
					-- null_ls.builtins.formatting.clang_format
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

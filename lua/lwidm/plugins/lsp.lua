return {
	{ 'neovim/nvim-lspconfig',
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ 'j-hui/fidget.nvim', opts = {} },
		},

		config = function()
			require('mason').setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					'lua_ls',
					'rust_analyzer',
					'clangd',
				},
				handlers = {
					function (server_name) --default handler (optional)
						print("setting up ", server_name)
						require("lspconfig")[server_name].setup {}
					end,
				}	
			})
		end
	},
}

-- plugins/fortran.lua

local enabled = true
local M = {}
if enabled then
	function M.setup_autocmds()
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = "*.f",
			callback = function()
				vim.bo.filetype = "fortran77"
			end,
		})

		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			pattern = "*.f90",
			callback = function()
				vim.bo.filetype = "fortran90"
			end,
		})
	end

	function M.setup_icons()
		local devicons = require("nvim-web-devicons")
		local fortran_icon, fortran_colour = devicons.get_icon("fortran")
		devicons.setup({
			override = {
				fortran77 = {
					icon = fortran_icon,
					color = "#FFD700",
					name = "fortran77",
				},
				fortran90 = {
					icon = fortran_icon,
					color = fortran_colour,
					name = "fortran90",
				},
			},
		})
	end

	function M.setup_treesitter()
		vim.treesitter.language.register("fortran", "fortran90")
		vim.treesitter.language.register("fortran", "fortran77")
	end

	-- function M.setup_lsp()
	-- 	require("lspconfig").fortls.setup({
	-- 		filetypes = { "fortran", "fortran77", "fortran90" },
	-- 		on_attach = function(client, bufnr)
	-- 			local filetype = vim.bo[bufnr].filetype
	--
	-- 			if filetype == "fortran77" then
	-- 				-- Enable fixed format for Fortran77
	-- 				client.server_capabilities.documentFormattingProvider = true
	-- 			elseif filetype == "fortran90" then
	-- 				-- Disable fixed format for Fortran90
	-- 				client.server_capabilities.documentFormattingProvider = false
	-- 			end
	-- 		end,
	-- 		settings = {
	-- 			fortran = {
	-- 				fixedFormat = {
	-- 					enable = true, -- Enable fixed format for Fortran77
	-- 				},
	-- 			},
	-- 		},
	-- 	})
	-- end

	-- function M.setup_formatting()
	-- 	-- Format using fprettify for Fortran files
	-- 	vim.api.nvim_create_user_command("FormatFortran", function()
	-- 		local filetype = vim.bo.filetype
	--
	-- 		if filetype == "fortran77" then
	-- 			-- Format Fortran77 files
	-- 			vim.cmd("silent !fprettify --fixed-format %")
	-- 		elseif filetype == "fortran90" then
	-- 			-- Format Fortran90 files
	-- 			vim.cmd("silent !fprettify --free-format %")
	-- 		end
	--
	-- 		vim.cmd("edit!") -- Reload the file after formatting
	-- 	end, {})
	-- end

	function M.setup()
		-- M.setup_icons()
		-- M.setup_lsp()
		M.setup_treesitter()
		M.setup_autocmds()
		-- M.setup_formatting()
	end
else
	-- function M.setup_icons() end
	-- function M.setup_lsp() end
	function M.setup_treesitter() end
	function M.setup_autocmds() end
	-- function M.setup_formatting() end
	function M.setup() end
end

return M

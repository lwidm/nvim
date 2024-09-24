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

	function M.setup_treesitter()
		vim.treesitter.language.register("fortran", "fortran90")
		vim.treesitter.language.register("fortran", "fortran77")
	end

	function M.setup()
		M.setup_treesitter()
		M.setup_autocmds()
	end
else
	function M.setup_treesitter() end
	function M.setup_autocmds() end
	function M.setup() end
end

return M

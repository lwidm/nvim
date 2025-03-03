local enabled = true
local plugin = {
	-- Autoformat
	"stevearc/conform.nvim",
	config = function()
		local lsp_serverlist = require("lwidm.lsp_serverlist")
		require("conform").setup({
			notify_on_error = true,
			-- format_on_save = function(bufnr)
			-- 	local disable_filetypes = { c = true, cpp = true }
			-- 	return {
			-- 		timeout_ms = 1000,
			-- 		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			-- 	}
			-- end,
			formatters_by_ft = lsp_serverlist.transform_format_servers(lsp_serverlist.format_servers, false),
		})

		-- Override Python formatter to use Black with a custom python executable path
		-- require("conform").formatters.black = function(bufnr)
		-- local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or os.getenv("PREFIX") or "/usr"
		-- local sep = package.config:sub(1, 1)
		-- local python_executable = virtual .. (sep == "\\" and "\\python.exe" or "/bin/python")
		-- return {
		-- command = "black",
		-- args = { "--python-executable", python_executable, "-" },
		-- }
		-- end

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ timeout_ms = 10000 })
		end, { desc = " [F]ormat" })
	end,
}

if enabled then
	return plugin
else
	return {}
end

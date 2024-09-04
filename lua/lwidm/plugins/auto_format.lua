-- lua/lwidm/plugins/auto_format.lua

local enabled = true
local plugin = {
	-- Autoformat
	"stevearc/conform.nvim",
	config = function()
		local lsp_serverlist = require("lwidm.lsp_serverlist")
		require("conform").setup({
			notify_on_error = true,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages thst don't have a well standardized coding style
				-- local disable_filetypes = { c = true, cpp = true }
				local disable_filetypes = { c = true }
				return {
					timeout_ms = 1000,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = lsp_serverlist.transform_format_servers(lsp_serverlist.format_servers, false),
		})
		-- stylua: ignore
		vim.keymap.set("n", "<leader>f", function() require("conform").format({timeout_ms=10000}) end, { desc = " [F]ormat" })
	end,
}
if enabled then
	return plugin
else
	return {}
end

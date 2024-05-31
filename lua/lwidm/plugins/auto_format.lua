-- lua/lwidm/plugins/auto_format.lua

local enabled = true
local plugin = {
	-- Autoformat
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			notify_on_error = true,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages thst don't have a well standardized coding style
				-- local disable_filetypes = { c = true, cpp = true }
				local disable_filetypes = { c = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				python = { "black" },
				nix = { "nixpkgs-fmt" },
				cmake = { "cmake_format" },
			},
		})
		-- stylua: ignore
		vim.keymap.set("n", "<leader>f", function() require("conform").format() end, { desc = " [F]ormat" })
	end,
}
if enabled then
	return plugin
else
	return {}
end

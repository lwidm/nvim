-- lua/lwidm/plugins/null-ls.lua

local enabled = true
local plugin = {
	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")
			local sources = {}
			if vim.fn.executable("mypy") == 1 then
				if vim.g.os_name == "Windows" then
					table.insert(
						sources,
						null_ls.builtins.diagnostics.mypy.with({
							extra_args = function()
								local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
								return { "--python-executable", virtual .. "\\python.exe" }
							end,
						})
					)
				else
					table.insert(sources, null_ls.builtins.diagnostics.mypy)
					-- TODO : maybe same thing as for windows but with the correct slashes
				end
			end
			if vim.fn.executable("ruff") == 1 then
				table.insert(sources, null_ls.builtins.diagnostics.ruff)
			end
			if vim.fn.executable("prettierd") == 1 then
				table.insert(sources, null_ls.builtins.formatting.prettierd)
			end
			null_ls.setup({
				sources = sources,
			})
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

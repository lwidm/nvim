-- lua/lwidm/plugins/none-ls.lua

local enabled = true
local plugin = {
	-- none-ls (null-ls replacement)
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			local none_ls = require("null-ls")
			local sources = {}

			-- Mypy configuration
			if vim.fn.executable("mypy") == 1 then
				table.insert(
					sources,
					none_ls.builtins.diagnostics.mypy.with({
						extra_args = function()
							local virtual = os.getenv("VIRTUAL_ENV")
								or os.getenv("CONDA_PREFIX")
								or os.getenv("PREFIX")
								or "/usr"
							-- Use OS-appropriate path separator
							local python_executable = virtual
								.. (package.config:sub(1, 1) == "\\" and "\\python.exe" or "/bin/python")
							return { "--python-executable", python_executable }
						end,
					})
				)
			else
				-- Fallback with POSIX path format
				table.insert(sources, none_ls.builtins.diagnostics.mypy)
			end

			-- Ruff configuration
			-- if vim.fn.executable("ruff") == 1 then
			-- 	table.insert(sources, none_ls.builtins.diagnostics.ruff)
			-- 	table.insert(sources, none_ls.builtins.formatting.ruff) -- Add formatting if needed
			-- end

			-- Prettier configuration
			if vim.fn.executable("prettierd") == 1 then
				table.insert(sources, none_ls.builtins.formatting.prettierd)
			end

			none_ls.setup({
				sources = sources,
				debounce = 250,
				root_dir = require("null-ls.utils").root_pattern(".git", "pyproject.toml", "package.json"),
			})
		end,
	},
}

return enabled and plugin or {}

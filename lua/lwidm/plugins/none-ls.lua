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
							local virtual_env = os.getenv("VIRTUAL_ENV")
							local conda_prefix = os.getenv("CONDA_PREFIX")
							local prefix = os.getenv("PREFIX")
							local virtual = virtual_env or conda_prefix or prefix

							-- No active environment: let mypy locate python itself
							if not virtual then
								return {}
							end

							local is_windows = (vim.g.os_name == "Windows")
							local is_conda = (virtual == conda_prefix) or (virtual == prefix)

							local python_executable
							if is_conda then
								python_executable = is_windows
									and (virtual .. "\\Scripts\\python.exe")
									or (virtual .. "/bin/python")
							else
								python_executable = is_windows
									and (virtual .. "\\Scripts\\python.exe")
									or (virtual .. "/bin/python")
							end

							if vim.fn.executable(python_executable) == 1 then
								return { "--python-executable", python_executable }
							end
							return {}
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

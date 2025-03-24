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

							-- Determine environment type
							local virtual = virtual_env or conda_prefix or prefix or "/usr"
							local is_windows = (vim.g.os_name == "Windows")
							local is_conda = conda_prefix and (virtual == conda_prefix)
								or (prefix and (virtual == prefix))

							-- Set Python path based on environment type and OS
							local python_executable
							if is_conda then
								if is_windows then
									python_executable = virtual .. "\\python.exe"
								else
									python_executable = virtual .. "/python"
								end
							else
								if is_windows then
									python_executable = virtual .. "\\Scripts\\python.exe"
								else
									python_executable = virtual .. "/bin/python"
								end
							end

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

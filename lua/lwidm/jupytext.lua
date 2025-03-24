M = {}

M.setup = function()
	local function get_current_file()
		return vim.fn.expand("%:p") -- Get full path of current file
	end

	local function convert_to_py()
		local file = get_current_file()
		if not file:match("%.ipynb$") then
			vim.notify("Not a .ipynb file", vim.log.levels.WARN)
			return
		end
		vim.fn.jobstart({ "jupytext", "--to", "py:percent", file }, { detach = true })
		vim.notify("Converted to .py:percent")
	end

	local function convert_to_notebook()
		local file = get_current_file()
		if not file:match("%.py$") then
			vim.notify("Not a .py file", vim.log.levels.WARN)
			return
		end
		vim.fn.jobstart({ "jupytext", "--to", "notebook", file }, { detach = true })
		vim.notify("Converted to .ipynb")
	end

	local function update_notebook()
		local file = get_current_file()
		-- Check for .py extension
		if not file:match("%.py$") then
			vim.notify("Not a .py file", vim.log.levels.WARN)
			return
		end

		-- Check if corresponding .ipynb exists
		local ipynb_file = file:gsub("%.py$", ".ipynb")
		if vim.fn.filereadable(ipynb_file) ~= 1 then
			vim.notify(
				"Corresponding .ipynb file not found: " .. ipynb_file .. ".\n Create .ipynb file first.",
				vim.log.levels.ERR
			)
			return
		end

		vim.fn.jobstart({ "jupytext", "--update", "--to", "notebook", file }, { detach = true })
		vim.notify("Updated .ipynb from .py")
	end

	local function open_help()
		local url = "https://jupytext.readthedocs.io/en/latest/using-cli.html"
		local cmd = nil
		if vim.fn.has("mac") == 1 then
			cmd = "open"
		elseif vim.fn.has("unix") == 1 then
			cmd = "xdg-open"
		elseif vim.fn.has("win32") == 1 then
			cmd = "start"
		end

		if cmd then
			vim.fn.jobstart({ cmd, url }, { detach = true })
		else
			vim.notify("Unsupported platform", vim.log.levels.ERROR)
		end
	end

	-- Set keybinds
	vim.keymap.set("n", "<leader>jtp", convert_to_py, { desc = "Jupytext: Convert to py:percent" })
	vim.keymap.set("n", "<leader>jtn", convert_to_notebook, { desc = "Jupytext: Convert to notebook" })
	vim.keymap.set("n", "<leader>jtu", update_notebook, { desc = "Jupytext: Update notebook" })
	vim.keymap.set("n", "<leader>jth", open_help, { desc = "Jupytext: Open CLI docs" })
end

return M

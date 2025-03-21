-- lua/lwidm/plugins/jupynium.lua

local enabled = false
local plugin = {
	{
		"kiyoon/jupynium.nvim",
		build = "pip3 install --user .",
		-- build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
		-- build = "conda run --no-capture-output -n jupynium pip install .",
		config = function()
			require("jupynium").get_folds()
			require("jupynium").setup({
				python_host = { "conda", "run", "--no-capture-output", "-n", "base", "python" },
				default_notebook_URL = "localhost:8888/nbclassic",
				-- Attach current nvim to the Jupynium server
				-- Without this step, you can't use :JupyniumStartSync
				-- Related command :JupyniumAttachToServer
				auto_attach_to_server = {
					enable = false,
					file_pattern = { "*.ju.*" },
				},
				-- Automatically open an Untitled.ipynb file on Notebook
				-- when you open a .ju.py file on nvim.
				-- Related command :JupyniumStartSync
				auto_start_sync = {
					enable = false,
					file_pattern = { "*.ju.*" },
				},
			})
		end,
	},
	"rcarriga/nvim-notify", -- optional
	"stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
}
if enabled then
	return plugin
else
	return {}
end

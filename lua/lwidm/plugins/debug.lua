-- plugins/debug.lua

local enabled = true
local plugin = {
	-- nvim-dap
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				"<cmd> DapToggleBreakpoint <CR>",
				mode = "n",
				desc = "[D]ebugging: Toggle [B]reakpoint",
			},
			{
				"<leader>drc",
				function()
					require("dap").continue()
				end,
				mode = "n",
				desc = "[D]ebugging: [R]un [C]ontinue",
			},
			-- { "<leader>dr", mode = "n", desc = "[D]ebugging: [R]un + prefix" },
		},
	},

	--nvim-nio
	{ "nvim-neotest/nvim-nio" },

	-- nvim-dap-ui
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
			"folke/neodev.nvim",
		},
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
			local dapui = require("dapui")
			dapui.setup()
			vim.fn.sign_define('DapBreakpoint', { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
		end,
		keys = {
			{ "<leader>dt", function() require("dapui").toggle() end, mode = "n", desc = "[D]ebug ui [T]oggle" },
			{ "<leader>db", function() require("dapui").toggleBreakpoint() end, mode = "n", desc = "[D]ebug ui [T]oggle" },
			{ "<leader>dc", function() require("dapui").continue() end, mode = "n", desc = "[D]ebug continue" },
			{ "<leader>dr", function() require("dapui").open({reset = true}) end, desc = "[D]ebug [R]eset ui" }
		},
	},

	-- neodev
	{
		"folke/neodev.nvim",
	},

	-- nvim-dap-python
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			if vim.loop.os_uname().sysname == "Windows_NT" then
				path = "~/AppData/Local/nvim-data/mason/packages/debugpy/venv/Scripts/python.exe"
			end

			-- Expand the path if it contains the home shortcut `~`
			path = vim.fn.expand(path)

			-- Setup dap-python with the specified path
			require("dap-python").setup(path)
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		opts = {
			handlers = {},
		},
	},
}
if enabled then
	return plugin
else
	return {}
end

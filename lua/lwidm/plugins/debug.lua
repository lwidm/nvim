-- plugins/debug.lua

local enabled = true
local plugin = {
	-- nvim-dap
	{
		"mfussenegger/nvim-dap",
		keys = {
			-- stylua: ignore start
			{ "<F5>", function() require("dap").continue() end, mode = "n", desc = "debug continue", },
			{ "<F8>", function() require('dap').step_over() end, mode = "n", desc = "debug step over", },
			{ "<F7>", function() require('dap').step_into() end, mode = "n", desc = "debug step into", },
			{ "<S-F8>", function() require('dap').step_out() end, mode = "n", desc = "debug step out", },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, mode = "n", desc = "[D]ebug ui [T]oggle", },
			{ "<Leader>dr", function() require('dap').repl.open() end, mode = "n", desc = "[D]ebug open [R]epl", },
			{ "<Leader>dl", function() require('dap').run_last() end, mode = "n", desc = "[D]ebug run [L]ast", },
			{ "<Leader>dh", function()
			  require('dap.ui.widgets').hover()
			end, mode = {'n', 'v'}, desc = "[D]ap ui [H]over", },
			{ "<Leader>dp", function()
			  require('dap.ui.widgets').preview()
			end, mode = {'n', 'v'}, desc = "[D]ap ui [P]review", },
			{ "<Leader>df", function()
			  local widgets = require('dap.ui.widgets')
			  widgets.centered_float(widgets.frames)
			end, mode = "n", desc = "[D]ap ui centered float [F]rames ?", },
			{ "<Leader>ds", function()
			  local widgets = require('dap.ui.widgets')
			  widgets.centered_float(widgets.scopes)
			end, mode = "n", desc = "[D]ap ui centered float [S]cope?", },
			-- stylua: ignore start
		},
	},

	-- nvim-nio
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
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🔴", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
		end,
		keys = {
			-- stylua: ignore start 
			{ "<leader>dt", function() require("dapui").toggle() end, mode = "n", desc = "[D]ebug ui [T]oggle",},
			{ "<leader>dR", function() require("dapui").open({ reset = true }) end, desc = "[D]ebug [R]eset ui", },
			{ "<leader>de", function() require("dapui").eval() end, desc = "[D]ebug ui [E]valuate expression", },
			-- stylua: ignore end
		},
	},

	-- nvim-dap-virtual-text
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
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

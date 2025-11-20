-- plugins/debug.lua

local enabled = true
local plugin = {
	-- nvim-dap
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
			"theHamsta/nvim-dap-virtual-text",
		},
		keys = {
			-- stylua: ignore start
			{ "<F5>", function() require("dap").continue() end, mode = "n", desc = "debug continue", },
			{ "<F10>", function() require('dap').step_over() end, mode = "n", desc = "debug step over", },
			{ "<F11>", function() require('dap').step_into() end, mode = "n", desc = "debug step into", },

			{ "<S-F11>", function() require('dap').step_out() end, mode = "n", desc = "debug step out", },
			{ "<F23>", function() require('dap').step_out() end, mode = "n", desc = "debug step out", },

			{ "<S-F5>", function() require('dap').terminate() end, mode = "n", desc = "debug step out", },
			{ "<F17>", function() require('dap').terminate() end, mode = "n", desc = "debug step out", },

			{ "<C-S-F5>", function() require('dap').restart() end, mode = "n", desc = "debug step out", },
			{ "<S-F10>", function() require('dap').restart() end, mode = "n", desc = "debug step out", },
			{ "<F22>", function() require('dap').restart() end, mode = "n", desc = "debug step out", },

			{ "<F9>", function() require("dap").toggle_breakpoint() end, mode = "n", desc = "[D]ebug [B]reakpoint toggle", },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, mode = "n", desc = "[D]ebug [B]reakpoint toggle", },
			{ "<leader>dc", function() require("dap").clear_breakpoints() end, mode = "n", desc = "[D]ebug [C]lear breakpoints", },
			{ "<Leader>dr", function() require('dap').repl.open() end, mode = "n", desc = "[D]ebug open [R]epl", },
			{ "<Leader>dl", function() require('dap').run_last() end, mode = "n", desc = "[D]ebug run [L]ast", },
			{ "<Leader>dh", function() require('dap.ui.widgets').hover() end, mode = {'n', 'v'}, desc = "[D]ap ui [H]over", },
			{ "<Leader>dp", function() require('dap.ui.widgets').preview() end, mode = {'n', 'v'}, desc = "[D]ap ui [P]review", },
			{ "<Leader>df", function()
			                    local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames)
				            end,
				mode = "n", desc = "[D]ap ui centered float [F]rames ?", },
			{ "<Leader>ds", function()
			                    local widgets = require('dap.ui.widgets')
			                    widgets.centered_float(widgets.scopes)
			                end,
				mode = "n", desc = "[D]ap ui centered float [S]cope?", },
			{ "]b", function() require("dap").list_breakpoints() end, mode = "n", desc = "goto next [B]reakpoint",},
			{ "[b", function() require("dap").list_breakpoints() end, mode = "n", desc = "goto previous [B]reakpoint",},
			-- stylua: ignore start
		},
		config = function()
			local dap = require("dap")

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
				name = "lldb",
			}

			dap.configurations = {
				c = {
					{
						name = "Launch file",
						type = "cppdbg",
						request = "launch",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopAtEntry = false,
						MIMode = "lldb",
					},
					{
						name = "Attach to lldbserver :1234",
						type = "cppdbg",
						request = "launch",
						MIMode = "lldb",
						miDebuggerServerAddress = "localhost:1234",
						miDebuggerPath = "/usr/bin/lldb",
						cwd = "${workspaceFolder}",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
					},
				},
			}

			-- Use same configuration for C
			dap.configurations.cpp = dap.configurations.c
		end,
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
		config = function()
			local lsp_serverlist = require("lwidm.lsp_serverlist")
			require("mason-nvim-dap").setup({
				ensure_installed = lsp_serverlist.dap_ensure_installed,
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

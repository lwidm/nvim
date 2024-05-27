-- plugins/debug.lua

return {
	-- nvim-dap
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>db", "<cmd> DapToggleBreakpoint <CR>", mode = "n", desc = "[D]ebugging: Toggle [B]reakpoint" },
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
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			-- dap.listeners.after.event_initialized["dapui_config"] = function()
			-- 	dapui.open()
			-- end
			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.envent_exited["dapui_config"] = function()
			-- 	dapui.close()
			-- end
		end,
		keys = {
			{
				"<leader>duo",
				function()
					require("dapui").open()
				end,
				mode = "n",
				desc = "[D]ebugging: [U]i [O]pen",
			},
			{
				"<leader>duc",
				function()
					require("dapui").close()
				end,
				mode = "n",
				desc = "[D]ebugging: [U]i [C]lose",
			},
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
				path = [[~\AppData\Local\nvim-data\mason\packages\debugpy\venv\Scripts\python]]
			end
			-- TODO: make sure this works for wsl and linux as well
			require("dap-python").setup(path)
		end,
		keys = {
			-- { "<leader>dt", mode = "n", desc = "[D]ebugging: [T]est + prefix" },
			{
				"<leader>dtm",
				function()
					require("dap-python").test_method()
				end,
				mode = "n",
				desc = "[D]ebugging: [T]est [M]ethod (above cursor)",
			},
			{
				"<leader>dtc",
				function()
					require("dap-python").test_class()
				end,
				mode = "n",
				desc = "[D]ebugging: [T]est [C]lass (above cursor)",
			},
			{
				"<leader>dts",
				function()
					require("dap-python").debug_selection()
				end,
				mode = "n",
				desc = "[D]ebugging: [T]est [S]election",
			},
		},
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

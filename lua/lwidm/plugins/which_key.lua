return {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ebug/[D]ocument", _ = "which_key_ignore" },
				["<leader>dr"] = { name = "[R]un", _ = "which_key_ignore" },
				["<leader>dt"] = { name = "[T]est", _ = "which_key_ignore" },
				["<leader>du"] = { name = "[U]i", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				["<leader>l"] = { name = "[L]anguage", _ = "which_key_ignore" },
			})
		end,
	},
}

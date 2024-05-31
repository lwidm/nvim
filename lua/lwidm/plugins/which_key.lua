-- lua/lwidm/plugin/which_key.lua

local enabled = true
local plugin = {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ebug/[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				["<leader>l"] = { name = "[L]anguage", _ = "which_key_ignore" },
				["<leader>t"] = { name = "[T]rouble", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
				["<leader>gd"] = { name = "[G]it [D]iff", _ = "which_key_ignore" },
				["<leader>gdg"] = { name = "[G]it [D]iff [G]et", _ = "which_key_ignore" },
				["<leader>gdp"] = { name = "[G]it [D]iff [P]ut", _ = "which_key_ignore" },
			})
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

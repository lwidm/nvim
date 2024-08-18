-- lua/lwidm/plugin/which_key.lua

local enabled = true
local plugin = {
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VeryLazy",
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

				["<localleader>l"] = { name = "[L]atex", _ = "which_key_ignore" },

				-- spelling
				["z="] = { name = "suggest correctly spelled word", _ = "which_key_ignore" },
				["zg"] = { name = "add word to good word list in spellfile", _ = "which_key_ignore" },
				["zw"] = { name = "add word to bad word list in spellfile", _ = "which_key_ignore" },
				["zG"] = { name = "add word to internal good word list", _ = "which_key_ignore" },
				["zW"] = { name = "add word to internal bad word list", _ = "which_key_ignore" },

				-- obsidian
				["<leader>o"] = { name = "obsidian / open folder", _ = "which_key_ignore" },
			})
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

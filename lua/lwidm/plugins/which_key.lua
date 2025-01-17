-- lua/lwidm/plugin/which_key.lua

local enabled = true
local plugin = {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		config = function()
			require("which-key").add({

				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ebug/[D]ocument" },
				{ "<leader>r", desc = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>l", group = "[L]anguage" },
				{ "<leader>t", group = "[T]rouble / [T]erminal" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>gd", group = "[G]it [D]iff" },
				{ "<leader>gdg", group = "[G]it [D]iff [G]et" },
				{ "<leader>gdp", group = "[G]it [D]iff [P]ut" },
				{ "<leader>m", group = "[M]arkdown / [M]atlab" },
				{ "<localleader>l", group = "[L]atex" },
				-- spelling
				-- { "z=", group = "suggest correctly spelled word" },
				-- { "zg", desc = "add word to good word list in spellfile" },
				-- { "zw", desc = "add word to bad word list in spellfile" },
				-- { "zG", desc = "add word to internal good word list" },
				-- { "zW", desc = "add word to internal bad word list" },
				-- obsidian
				{ "<leader>o", group = "obsidian / open folder" },

				{ "@", group = "Play Macro" },
				{ "@a", desc = "Play Macro: a" }, -- Example
				-- Macro record
				{ "q", group = "Record Macro" },
				{ "qa", desc = "Record Macro: a" }, -- Example

				-- Terminal
				{ "<leader>tc", group = "[T]erminal [C]make" },
				{ "<leader>tcc", group = "[T]erminal [C]make [C]onfigure" },
				{ "<leader>tcb", group = "[T]erminal [C]make [B]uild" },

				-- Magma
				{ "<locallleader>r", group = "Magma (jupyter)" },
			})
		end,
	},
	-- { -- Useful plugin to show you pending keybinds.
	-- 	"folke/which-key.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("which-key").setup()
	-- 		require("which-key").register({
	-- 			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	-- 			["<leader>d"] = { name = "[D]ebug/[D]ocument", _ = "which_key_ignore" },
	-- 			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	-- 			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
	-- 			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
	-- 			["<leader>l"] = { name = "[L]anguage", _ = "which_key_ignore" },
	-- 			["<leader>t"] = { name = "[T]rouble", _ = "which_key_ignore" },
	-- 			["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
	-- 			["<leader>gd"] = { name = "[G]it [D]iff", _ = "which_key_ignore" },
	-- 			["<leader>gdg"] = { name = "[G]it [D]iff [G]et", _ = "which_key_ignore" },
	-- 			["<leader>gdp"] = { name = "[G]it [D]iff [P]ut", _ = "which_key_ignore" },
	-- 			["<leader>m"] = { name = "[M]arkdown / [M]atlab", _ = "which_key_ignore" },
	--
	-- 			["<localleader>l"] = { name = "[L]atex", _ = "which_key_ignore" },
	--
	-- 			-- spelling
	-- 			-- ["z="] = { name = "suggest correctly spelled word", _ = "which_key_ignore" },
	-- 			-- ["zg"] = { name = "add word to good word list in spellfile", _ = "which_key_ignore" },
	-- 			-- ["zw"] = { name = "add word to bad word list in spellfile", _ = "which_key_ignore" },
	-- 			-- ["zG"] = { name = "add word to internal good word list", _ = "which_key_ignore" },
	-- 			-- ["zW"] = { name = "add word to internal bad word list", _ = "which_key_ignore" },
	--
	-- 			-- obsidian
	-- 			["<leader>o"] = { name = "obsidian / open folder", _ = "which_key_ignore" },
	-- 		})
	-- 	end,
	-- },
}
if enabled then
	return plugin
else
	return {}
end

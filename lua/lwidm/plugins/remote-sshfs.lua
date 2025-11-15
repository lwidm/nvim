-- lua/lwidm/plugins/remote-sshfs.lua

local enabled = true
local plugin = {
	{
		"nosduco/remote-sshfs.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			-- Refer to the configuration section below
			-- or leave empty for defaults
		},
		config = function()
			require('remote-sshfs').setup({})
			require("telescope").load_extension("remote-sshfs")
			local api = require("remote-sshfs.api")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>rc", api.connect, { desc = "[R]emote sshfs [C]onnect" })
			vim.keymap.set("n", "<leader>rd", api.disconnect, { desc = "[R]emote sshfs [D]isconnect" })
			vim.keymap.set("n", "<leader>re", api.edit, { desc = "[R]emote sshfs [E]dit" })

			local connections = require("remote-sshfs.connections")

			vim.keymap.set("n", "<leader>sf", function()
				if connections.is_connected() then
					api.find_files()
				else
					builtin.find_files()
				end
			end, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", function()
				if connections.is_connected() then
					api.live_grep()
				else
					builtin.live_grep()
				end
			end, { desc = "[S]earch by [G]rep" })
		end,
	},
}

if enabled then
	return plugin
else
	return {}
end

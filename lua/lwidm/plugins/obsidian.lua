-- lua/lwidm/plugins/obsidian.lua

local vault_path = vim.fn.expand("~") .. "/OneDrive/Documents/02_Obsidian_Vault/"
if vim.g.os_name == "Windows" then
	local vault_path = vim.fn.expand("~") .. "\\OneDrive\\Documents\\2_Obsidian_Vault\\"
end

local not_for_systems = { "wslDesktop", "wslLaptop", "wslMaerz", "msys2" }

local enabled = true
local plugin = {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		-- ft = "markdown",
		event = {
			"VeryLazy",
			-- "BufReadPre " .. vault_path .. "*.md",
			-- "BufNewFile " .. vault_path .. "*.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "Default",
						path = vault_path .. "Default",
					},
				},
				completion = {
					nvim_cmp = true,
					min_chars = 2,
				},
				finder = "telescope.nvim",
				mapping = {
					-- make gd do the same thing as gf
					["gd"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
				},
				templates = {
					folder = vault_path .. "Templates",
					date_format = "%Y.%m.%d %a",
					time_format = "%H:%M:%S",
				},
			})
			vim.keymap.set(
				"n",
				"<leader>so",
				":ObsidianQuickSwitch<CR>",
				{ desc = "[S]earch [O]bsidian notes", silent = true }
			)
			vim.keymap.set(
				"n",
				"<leader>sO",
				":ObsidianSearch<CR>",
				{ desc = "[S]earch words in [O]bsidian notes", silent = true }
			)
			vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>", { desc = "[O]bsidian [O]pen note", silent = true })
			vim.keymap.set(
				"n",
				"<leader>on",
				":ObsidianNewFromTemplate ",
				{ desc = "[O]bsidian [N]ew note", silent = false }
			)
			vim.keymap.set(
				"n",
				"<leader>op",
				":ObsidianPasteImg ",
				{ desc = "[O]bsidian [P]aste Image", silent = false }
			)
		end,
	},
}
-- disabled for wsl and MSYS2 systems
for _, system in pairs(not_for_systems) do
	if system == os.getenv("MYSYSTEM") or vim.fn.getenv("MSYSTEM") then
		enabled = false
	end
end
if enabled then
	return plugin
else
	return {}
end

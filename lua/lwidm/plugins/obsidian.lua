-- lua/lwidm/plugins/obsidian.lua

local vault_path = vim.fn.expand("~") .. "/OneDrive-mount/Documents/02_Obsidian_Vault/"
if vim.g.os_name == "Windows" then
	vault_path = vim.fn.expand("~") .. "\\OneDrive\\Documents\\02_Obsidian_Vault\\"
end

local not_for_systems = { "wslMaerz", "msys2" }

local enabled = true
local plugin = {
	{
		-- maintained community fork of the (archived) epwalsh/obsidian.nvim
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",
		lazy = true,
		-- These keymaps double as lazy-load triggers, so they work even when the
		-- first buffer you touch is not a markdown note (e.g. quick-switching in).
		keys = {
			{ "<leader>oo", "<cmd>Obsidian open<CR>", desc = "[O]bsidian [O]pen note in app" },
			{ "<leader>so", "<cmd>Obsidian quick_switch<CR>", desc = "[S]earch [O]bsidian notes (filenames)" },
			{ "<leader>sO", "<cmd>Obsidian search<CR>", desc = "[S]earch words in [O]bsidian notes" },
			{ "<leader>on", ":Obsidian new ", desc = "[O]bsidian [N]ew note" },
			{ "<leader>oN", ":Obsidian new_from_template ", desc = "[O]bsidian [N]ew note from template" },
			{ "<leader>oT", "<cmd>Obsidian template<CR>", desc = "[O]bsidian insert [T]emplate" },
			{ "<leader>op", "<cmd>Obsidian paste_img<CR>", desc = "[O]bsidian [P]aste image" },
			{ "<leader>of", "<cmd>Obsidian follow_link<CR>", desc = "[O]bsidian [F]ollow link" },
			{ "<leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "[O]bsidian [B]acklinks" },
			{ "<leader>ol", "<cmd>Obsidian links<CR>", desc = "[O]bsidian [L]inks in note" },
			{ "<leader>oj", "<cmd>Obsidian toc<CR>", desc = "[O]bsidian table of contents (jump)" },
			{ "<leader>or", "<cmd>Obsidian rename<CR>", desc = "[O]bsidian [R]ename note" },
			{ "<leader>od", "<cmd>Obsidian today<CR>", desc = "[O]bsidian [D]aily note (today)" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("obsidian").setup({
				-- Use the new ":Obsidian <subcommand>" command tree instead of the
				-- deprecated ":ObsidianOpen"-style commands (removed in 4.0.0).
				legacy_commands = false,
				workspaces = {
					{
						name = "Default",
						path = vault_path .. "Default",
					},
				},
				-- Name new notes after the title you type (slugified), instead of
				-- the default random zettel IDs like "1782199887-ZTGL".
				note_id_func = require("obsidian.builtin").title_id,
				completion = {
					-- nvim-cmp/blink are auto-detected now; just tune behavior here.
					min_chars = 2,
				},
				-- Was `finder = "telescope.nvim"` on the old plugin.
				picker = {
					name = "telescope.nvim",
				},
				-- Built-in concealment-based markdown rendering (replaces markview).
				-- Requires conceallevel >= 1 (set in lwidm/init.lua).
				ui = {
					enable = true,
				},
				templates = {
					folder = vault_path .. "Templates",
					-- strftime tokens (containing %) are still honored by the fork.
					date_format = "%Y.%m.%d %a",
					time_format = "%H:%M:%S",
				},
				-- Buffer-local keymaps that only make sense inside an actual note.
				callbacks = {
					enter_note = function(note)
						local bufnr = note.bufnr or vim.api.nvim_get_current_buf()
						local opts = { buffer = bufnr, silent = true }

						-- make gd/gf follow the link under the cursor (old gf_passthrough)
						vim.keymap.set("n", "gd", "<cmd>Obsidian follow_link<CR>",
							vim.tbl_extend("force", opts, { desc = "Obsidian follow link" }))
						vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<CR>",
							vim.tbl_extend("force", opts, { desc = "Obsidian follow link" }))

						-- toggle a markdown checkbox on the current line
						vim.keymap.set("n", "<leader>oc", "<cmd>Obsidian toggle_checkbox<CR>",
							vim.tbl_extend("force", opts, { desc = "[O]bsidian toggle [C]heckbox" }))

						-- visual-mode actions on the selection
						vim.keymap.set("v", "<leader>oe", ":Obsidian extract_note<CR>",
							vim.tbl_extend("force", opts, { desc = "[O]bsidian [E]xtract selection to new note" }))
						vim.keymap.set("v", "<leader>ok", ":Obsidian link<CR>",
							vim.tbl_extend("force", opts, { desc = "[O]bsidian lin[K] selection to a note" }))
					end,
				},
			})
		end,
	},
}
-- disabled for wsl and MSYS2 systems
for _, system in pairs(not_for_systems) do
	if system == os.getenv("MYSYSTEM") or not vim.fn.getenv("MSYSTEM") then
		enabled = false
	end
end
if enabled then
	return plugin
else
	return {}
end

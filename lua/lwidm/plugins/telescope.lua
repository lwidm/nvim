-- lua/lwidm/plugins/telescope.lua

local enabled = true
local action
local plugin = {

	{
		"nvim-telescope/telescope-ui-select.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-tree/nvim-web-devicons", lazy = false },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						".git",
						"^%.git/",
						"^node_modules/",
						".mypy_cache",
						"__pycache__",
						".spyproject",
						"^%.cache/",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})

			pcall(require("telescope").load_extensions, "fzf")
			pcall(require("telescope").load_extensions, "live_grep")

			-- stylua: ignore start
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set('n', '<leader>sF', function()
				builtin.find_files({
					find_command = {
						"fd", "--type", "f", "--hidden", "--no-ignore", "--strip-cwd-prefix"
					}
				})
			end, { desc = "[S]earch all [F]iles (no .gitignore)" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set('v', "<leader>ss", 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', { desc = "[S]earch [S]election" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sl", function() local word = vim.fn.expand("<cWORD>") builtin.grep_string({ search = word }) end, { desc = "[S]earch current long [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sG", builtin.git_files, { desc = "[S]earch [G]it files" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostic" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
			--stylua: ignore end

			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching the Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
if enabled then
	return plugin
else
	return {}
end

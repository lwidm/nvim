-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear highlight on search" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>x", "<cmd>Ex<CR>")

-- Keybinds to make split navigation easier
-- if not vim.g.tmux_nav then
--	vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
--	vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
--	vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
--	vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--end
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "jump half page [D]own" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "jump half page [U]p" })

-- spellchecking remaps
-- stylua: ignore start
vim.keymap.set( "n", "<leader>lt", "<cmd>set spell!<CR>", { desc = "[L]anguage spell checking [T]oggle" })
vim.keymap.set( "n", "<leader>le", "<cmd>setlocal spell spelllang=en_au<CR>", { desc = "[L]anguage spell checking set [E]nglish" } )
vim.keymap.set( "n", "<leader>ld", "<cmd>setlocal spell spelllang=de_ch<CR>", { desc = "[L]anguage spell checking set [G]erman" } )
-- stylua: ignore end

vim.keymap.set("n", "<M-k>", "<C-w>+", { desc = "Increase height" })
vim.keymap.set("n", "<M-j>", "<C-w>-", { desc = "Decrease height" })
vim.keymap.set("n", "<M-l>", "<C-w>>", { desc = "Increase width" })
vim.keymap.set("n", "<M-h>", "<C-w><", { desc = "Decrease width" })

-- moving selecionts
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv", { desc = "goto [N]ext search term" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "goto previous search term" })

-- paste over without loosing previous yank
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "[P]aste over without loosing yank" })

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.

		-- stylua: ignore start
		vim.keymap.set( "n", "gd", require("telescope.builtin").lsp_definitions, { buffer = event.buf, desc = "LSP: [G]oto [D]efinition" } )

		-- Find references for the word under your cursor.
		vim.keymap.set( "n", "gr", require("telescope.builtin").lsp_references, { buffer = event.buf, desc = "LSP: [G]oto [R]eferences" } )

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		vim.keymap.set( "n", "gI", require("telescope.builtin").lsp_implementations, { buffer = event.buf, desc = "LSP: [G]oto [I]mplementation" } )

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		vim.keymap.set( "n", "<leader>D", require("telescope.builtin").lsp_type_definitions, { buffer = event.buf, desc = "LSP: [T]ype [D]efinition" } )

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		vim.keymap.set( "n", "<leader>sD", require("telescope.builtin").lsp_document_symbols, { buffer = event.buf, desc = "LSP: [S]earch [D]ocument symbols" } )

		-- Fuzzy find all the symbols in your current workspace.
	--  Similar to document symbols, except searches over your entire project.
		vim.keymap.set( "n", "<leader>sW", require("telescope.builtin").lsp_dynamic_workspace_symbols, { buffer = event.buf, desc = "LSP: [S]earch [W]orkspace symbols" })

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		vim.keymap.set( "n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, desc = "LSP: [R]e[n]ame" })

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		vim.keymap.set( { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "LSP: [C]ode [A]ction" } )

		-- Opens a popup that displays documentation about the word under your cursor
		--  See `:help K` for why this keymap.
		vim.keymap.set( { "n", "v" }, "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "LSP: Hover Documentation" })

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf, desc = "[G]oto [D]eclaration" })
		-- stylua: ignore end
	end,
})

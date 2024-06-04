-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local get_os_name = require("lwidm.get_os_name")
vim.g.os_name = get_os_name()
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
-- Case insensitive seraching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
-- Decrease update time and mapped sequence wait time (Displays which-key popup sooner)
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
-- Set how neovim will display certain whitespaces
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- give a live preview of substitutions
vim.opt.inccommand = "split"
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

vim.opt.splitbelow = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "~/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.g.lsp_servers = {
	clangd = {}, -- c, cpp
	codelldb = {}, -- c, cpp debugger
	rust_analyzer = {}, -- rust
	lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } }, -- lua
	cmakelang = {}, -- cmake
	pyright = {}, -- python
	debugpy = {}, -- python debugging
	-- jsonls = {}, -- json
	-- web
	-- html = {}, -- html
	-- cssls = {}, -- css
	-- tsserver = {}, -- javascript, typescript
	-- intelephense = {}, -- php
}
vim.g.format_servers = {
	"stylua", -- lua
	"clang-format", -- c and c++
	"black", -- python
}
vim.g.other_lsp_tools = {
	"mypy", -- python: static typing
	"ruff", -- python: linter and formatter
}

if vim.g.os_name == "Linux" then
	vim.list_extend(vim.g.lsp_servers, {
		nil_ls = {}, -- nix
	})
	vim.list_extend(vim.g.format_servers, {
		"nixpkgs-fmt", -- NixOs
	})
end

require("lwidm.misc")
require("lwidm.noArrowKeys")
require("lwidm.lazy")
require("lwidm.remap")

require("lwidm.auto_update")()

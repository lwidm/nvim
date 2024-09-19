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
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.wo.conceallevel = 0 -- no concealment. Charachters are displayed as-is.
-- vim.wo.conceallevel = 1 -- Conceal single-character items (e.g., asterisks for bold text in Markdown)
-- vim.wo.conceallevel = 2 -- Conceal both single-character items and multi-character items (e.g., entire words or phrases).

require("lwidm.misc")
require("lwidm.noArrowKeys")
require("lwidm.remap")
require("lwidm.lazy")

require("lwidm.auto_update")()

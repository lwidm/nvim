-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
-- Case insensitive seraching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
-- Decrease update time and mapped sequence wait time (Displays which-key popup sooner)
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
-- Set how neovim will display certain whitespaces
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- give a live preview of substitutions
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

require("lwidm.remap")
require("lwidm.misc")
require("lwidm.noArrowKeys")
require("lwidm.lazy")

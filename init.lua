-- init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local get_os_name = require("lwidm.get_os_name")
vim.g.os_name = get_os_name()

require("lwidm.auto_update")()

require("lwidm")

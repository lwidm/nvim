-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Transparent background
vim.cmd("set background=dark")
vim.cmd("highlight Normal ctermbg=none guibg=none")
vim.cmd("highlight TelescopeNormal ctermbg=none guibg=none")

-- Language settings
-- C/C++ settings (2 spaces for tabs)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "h", "hpp" },
	command = "setlocal tabstop=2 shiftwidth=2 expandtab",
})

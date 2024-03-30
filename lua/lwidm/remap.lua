-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>noholsearch<CR>', {desc = 'clear highlight on search'})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'Go to previous [D]iagnostic message'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'Go to next [D]iagnostic message'})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = 'Show diagnostic [E]rror messages'})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostic [Q]uickfix list'})

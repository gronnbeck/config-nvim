vim.keymap.set('n', '<leader>tt', '<C-z><CR>', { noremap = true, silent = true, desc = 'Drop into terminal' })

-- vim.keymap.set('n', '<leader>ef', require("conform").format, { noremap = true, silent = true, desc = 'Autoformat file' })

vim.keymap.set('n', '<leader>fp', function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, { noremap = true, silent = true, desc = 'Copy rel path to clipboard' })


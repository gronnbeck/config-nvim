local actions = require('telescope.actions')

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  }
})

local builtin = require('telescope.builtin')

----------------------------------------------
--               KEYBINDINGS                --
----------------------------------------------

vim.api.nvim_set_keymap('n', '<leader>fs', ':w<CR>', { noremap = true, silent = true, desc = 'Save current file' })

-- Setting up Telescope bindings
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- Requires ripgrep installed
-- $ brew install ripgrep
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope grep files' })

vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })

vim.keymap.set('n', '<leader>p', builtin.commands, { desc = 'Telescope commands' })

vim.keymap.set('n', '<leader>ec', function()
  builtin.find_files {
    cwd = vim.fn.stdpath('config'),
    desc = "nvim config files"
  }
end)

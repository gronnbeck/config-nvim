-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
          'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
          -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
          -- animation = true,
          -- insert_at_start = true,
          -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
    {'romgrk/barbar.nvim',
        dependencies = {
          'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
          -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
          -- animation = true,
          -- insert_at_start = true,
          -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
      },
      {
          "jiaoshijie/undotree",
          dependencies = "nvim-lua/plenary.nvim",
          config = true,
          keys = { -- load the plugin only when using it's keybinding:
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
      },
      {
        'tpope/vim-fugitive',
        config = function()
            -- Optional: Set up key mappings for common Fugitive commands
            vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true, silent = true }) -- Git status
            vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true }) -- Git commit
            vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { noremap = true, silent = true }) -- Git push
        end
      },
      {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
      {'neovim/nvim-lspconfig'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/nvim-cmp'},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},
      {"slim-template/vim-slim"},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

local config = require("nvim-treesitter.configs")

config.setup({
  ensure_installed = { "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "typescript", "ruby" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})

local wk = require("which-key")

-- Setting up Neotree opening
vim.keymap.set('n', '<leader>0', ':Neotree<CR>', { noremap = true, silent = true, desc = 'Open file tree' })


-- Window management
vim.keymap.set('n', '<leader>wNv', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>wNh', ':split<CR>', { noremap = true, silent = true, desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>wx', ':close<CR>', { noremap = true, silent = true, desc = 'Close current window' })
vim.keymap.set('n', '<leader>wh', '<C-w>h<CR>', { noremap = true, silent = true, desc = 'Move to window to the left' })
vim.keymap.set('n', '<leader>wj', '<C-w>j<CR>', { noremap = true, silent = true, desc = 'Move to window below' })
vim.keymap.set('n', '<leader>wk', '<C-w>k<CR>', { noremap = true, silent = true, desc = 'Move to window above' })
vim.keymap.set('n', '<leader>wl', '<C-w>l<CR>', { noremap = true, silent = true, desc = 'Move to window to the right' })


local opts = { noremap = true, silent = true }

-- Buffer management mappings

-- Open buffer list and switch to another buffer
vim.keymap.set('n', '<leader>bb', ':Telescope buffers<CR>', { noremap = true, silent = true, desc = 'List buffers' })

-- Switch to the previous buffer
vim.keymap.set('n', '<leader><Tab>', ':b#<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })

-- Move to the next buffer in the list
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true, desc = 'Move to the next buffer' })

-- Move to the previous buffer in the list
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Move to the previous buffer' })

-- Kill (delete) the current buffer
vim.keymap.set('n', '<leader>bx', ':bprevious|bdelete #<CR>', { noremap = true, silent = true, desc = 'Delete the current buffer' })

-- Kill other buffers except the current one
vim.keymap.set('n', '<leader>b<C-d>', ':%bd|e#|bd#<CR>', { noremap = true, silent = true, desc = 'Kill other buffers except current one' })

-- Kill all buffers
vim.keymap.set('n', '<leader>bD', ':%bd|e#<CR>', { noremap = true, silent = true, desc = 'Kill all buffers' })

-- Reopen the last closed buffer
vim.keymap.set('n', '<leader>bR', ':e#<CR>', { noremap = true, silent = true, desc = 'Reopen the last closed buffer' })

-- Access the recent files list to reopen a recently closed file
vim.keymap.set('n', '<leader>fr', ':Telescope oldfiles<CR>', { noremap = true, silent = true, desc = 'Reopen recently closed files' })

-- Show information about the current buffer
vim.keymap.set('n', '<leader>bi', ':echo "Buffer: " . bufname("%")<CR>', opts)

-- List all open buffers in a help-like pop-up window
vim.keymap.set('n', '<leader>bh', ':ls<CR>:b<Space>', opts)

-- Move buffer to the right split
vim.keymap.set('n', '<leader>wL', '<C-w>L', opts)

-- Move buffer to the left split
vim.keymap.set('n', '<leader>wH', '<C-w>H', opts)

-- Move buffer to the bottom split
vim.keymap.set('n', '<leader>wJ', '<C-w>J', opts)

-- Move buffer to the top split
vim.keymap.set('n', '<leader>wK', '<C-w>K', opts)

-- Move to window
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<Leader>' .. i, ':' .. i .. 'wincmd w<CR>', { noremap = true, silent = true, desc = 'Window ' .. i })
end

vim.keymap.set('n', '<leader>b1', '<Cmd>BufferGoto 1<CR>', opts)
vim.keymap.set('n', '<leader>b2', '<Cmd>BufferGoto 2<CR>', opts)
vim.keymap.set('n', '<leader>b3', '<Cmd>BufferGoto 3<CR>', opts)
vim.keymap.set('n', '<leader>b4', '<Cmd>BufferGoto 4<CR>', opts)
vim.keymap.set('n', '<leader>b5', '<Cmd>BufferGoto 5<CR>', opts)
vim.keymap.set('n', '<leader>b6', '<Cmd>BufferGoto 6<CR>', opts)
vim.keymap.set('n', '<leader>b7', '<Cmd>BufferGoto 7<CR>', opts)
vim.keymap.set('n', '<leader>b8', '<Cmd>BufferGoto 8<CR>', opts)
vim.keymap.set('n', '<leader>b9', '<Cmd>BufferGoto 9<CR>', opts)
vim.keymap.set('n', '<leader>b0', '<Cmd>BufferLast<CR>', opts)

-- Function to open a new buffer to the left
local function open_buffer_to_left()
  -- Get the buffer number of the current buffer
  local current_buffer = vim.api.nvim_get_current_buf()

  -- Open a new empty buffer
  vim.cmd('enew')

  -- Move the new buffer to the previous position (left of the original buffer)
  vim.cmd('BufferMovePrevious')

  -- Optionally, switch back to the new buffer
  -- vim.api.nvim_set_current_buf(vim.fn.bufnr('%'))
end

vim.keymap.set('n', '<leader>bNl', open_buffer_to_left, opts)

-- Function to open a new buffer to the right
local function open_buffer_to_right()
  -- Open a new empty buffer
  vim.cmd('enew')

  -- Move the new buffer to the next position (right of the original buffer)
  vim.cmd('BufferMoveNext')
end

vim.keymap.set('n', '<leader>bNr', open_buffer_to_right, opts)

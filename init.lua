vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard+=unnamedplus")

require("config.lazy")
require('config.lsp')
require('config.telescope')
require('config.lsp-telescope')
require('config.keybinding-misc')



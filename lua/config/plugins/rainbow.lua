return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- base setup: no config needed, plugin works out of the box
      -- if you later want to tweak:
      -- local rainbow_delimiters = require "rainbow-delimiters"
      -- vim.g.rainbow_delimiters = { ... }
    end,
  },
}

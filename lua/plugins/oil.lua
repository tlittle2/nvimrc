local utils = require("utils")

return {
  enabled = true,

  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  config = function()
    require("oil").setup()
    vim.keymap.set(utils.vim.mode.normal, "-", utils.vim.runVimCommand("Oil"), { desc = "Open parent directory" })
    vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader("-"), utils.vim.runVimCommand("topleft vs | Oil"), { desc = "Open parent directory" })
  end
}

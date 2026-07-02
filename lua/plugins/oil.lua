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

    local maps = {
      ["-"] = {utils.vim.runVimCommand("Oil"), "Open parent directory"},
      [utils.vim.prefixLeader("-")] = {utils.vim.runVimCommand("topleft vs | Oil"), "Open parent directory"},
    }

    utils.loop(maps, function(k,v) vim.keymap.set(utils.vim.mode.normal, k, v[1], { desc = v[2] }) end)

  end
}

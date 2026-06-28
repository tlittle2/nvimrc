local utils = require('utils')
return {
  {
    "tpope/vim-fugitive",
    lazy = false, -- to prevent breaking core features
    config = function()
      vim.keymap.set(utils.vim.mode.normal, utils.vim.prefixLeader("gs"), vim.cmd.Git, { desc = "Git Status" })
    end
  }
}

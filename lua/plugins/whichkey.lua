local utils = require("utils")

return { -- Useful plugin to show you pending keybinds.
  enabled = true,
  'folke/which-key.nvim',
  event = 'VimEnter',
  ---@module 'which-key'
  ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },

    -- Document existing key chains
    spec = {
      { utils.vim.prefixLeader('s'), group = '[S]earch', mode = { utils.vim.mode.normal, utils.vim.mode.visual } },
      { utils.vim.prefixLeader('t'), group = '[T]oggle' },
      { utils.vim.prefixLeader('h'), group = 'Git [H]unk', mode = { utils.vim.mode.normal, utils.vim.mode.visual } }, -- Enable gitsigns recommended keymaps first
      { utils.vim.prefixLeader('ms'), group = '[M]ini [S]urround', mode = { utils.vim.mode.visual } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { utils.vim.mode.normal } },
    },
  },
}

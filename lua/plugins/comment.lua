return  {-- Highlight todo, notes, etc in comments
  enabled = true,
  'folke/todo-comments.nvim',
  event = { "BufReadPost", "BufNewFile" },
  --event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  ---@module 'todo-comments'
  ---@type TodoOptions
  ---@diagnostic disable-next-line: missing-fields
  opts = { signs = false },
}

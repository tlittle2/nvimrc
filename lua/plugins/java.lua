return {
  'nvim-java/nvim-java',
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load on buffer events (only while editing text, not in Oil)
  config = function()
    require('java').setup()
    vim.lsp.enable('jdtls')
  end,
  enabled = false
}

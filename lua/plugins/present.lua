return {
  'tjdevries/present.nvim',
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load on buffer events
  ft = "markdown",
}

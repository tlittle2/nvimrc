local utils = require("utils")
return {
  "jiaoshijie/undotree",
  opts = {
    -- your options
  },
  keys = { -- load the plugin only when using it's keybinding:
    { utils.vim.prefixLeader("u"), utils.vim.runVimCommand("lua require('undotree').toggle()") },
  },
}

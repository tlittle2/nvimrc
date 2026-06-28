local utils = require("utils")
return {
    "diegoulloao/neofusion.nvim"
    , priority = utils.vim.maxPriority
    --, config = true
    , config = function()
        vim.o.background = "dark"
        vim.cmd([[ colorscheme neofusion ]])
    end,
    opts = ...,
    enabled = false,

}

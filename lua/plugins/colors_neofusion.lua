return {
    "diegoulloao/neofusion.nvim"
    , priority = 1000
    --, config = true
    , config = function()
        vim.o.background = "dark"
        vim.cmd([[ colorscheme neofusion ]])
    end,
    opts = ...,
    enabled = false,

}

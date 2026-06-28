return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    enabled = false,

    config = function()
        require("neo-tree").setup({
          event_handlers = {
            {
              event = "neo_tree_buffer_enter",
              handler = function(arg)
                vim.cmd [[
                  setlocal relativenumber
                ]]
              end,
            }
          },
        })
    end
  }
}

return {
  "ajbucci/ipynb.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    -- "nvim-tree/nvim-web-devicons", -- optional, for language icons
    -- "folke/snacks.nvim", -- optional, for inline images
  },
  opts = {
    ft = "python"
  },

}

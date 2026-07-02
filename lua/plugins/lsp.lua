return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "rust_analyzer", "basedpyright" , "gopls" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  --START of lsp installs
  {
    "neovim/nvim-lspconfig",

    vim.lsp.enable("basedpyright"),
    vim.lsp.enable("gopls"),
    vim.lsp.enable("rust_analyzer"),

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    }),
  },
  --END   of lsp installs
}

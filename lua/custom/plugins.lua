local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "lua",

        -- user-defined
        "c",
        "cpp",
        "python",
        "go",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspconfig'
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "stylua"
      },
    },
  }
}

return plugins

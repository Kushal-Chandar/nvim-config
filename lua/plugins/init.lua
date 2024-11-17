return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    cmd = "FormatToggle",
    dependencies = require("configs.conform").dependencies,
    config = require("configs.conform").config,
  },
  {
    "neovim/nvim-lspconfig",
    config = require("configs.lspconfig").config,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "CmdlineEnter",
    dependencies = require("configs.cmp").add_dependencies,
    config = require("configs.cmp").config,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = require("configs.noice").dependencies,
    opts = {},
    config = require("configs.noice").config,
  },
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost", -- Automatically lint on file save
    config = function()
      require("lint").linters_by_ft = {
        python = { "ruff" },
        lua = { "luacheck" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        sh = { "shellcheck" },
        markdown = { "markdownlint" },
      }

      -- Auto-lint on file save
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}

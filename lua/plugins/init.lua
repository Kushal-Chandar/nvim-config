return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cmd = require("configs.treesitter-context").cmd,
    event = require("configs.treesitter-context").event,
    dependencies = require("configs.treesitter-context").dependencies,
    config = require("configs.treesitter-context").config,
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
  -- {
  --   "stevearc/dressing.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   config = require("configs.dressing").config,
  -- },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = require "configs.inc-rename",
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "folke/trouble.nvim",
    dependencies = require("configs.trouble").dependencies,
    opts = require("configs.trouble").opts,
    cmd = require("configs.trouble").cmd,
    keys = require("configs.trouble").keys,
  },
  {
    "mfussenegger/nvim-lint",
    event = require("configs.nvim-lint").event,
    config = require("configs.nvim-lint").config,
  },
}

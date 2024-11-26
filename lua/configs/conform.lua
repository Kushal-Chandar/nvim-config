local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "prettier" },

    --web
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettier" },
    toml = { "taplo" },
    go = { "goimports", "gofmt" },

    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    rust = { "rustfmt", lsp_format = "fallback" },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

local M = {}

M.dependencies = {
  "rcarriga/nvim-notify",
}

M.config = function()
  -- Had to create config to use require notify
  -- alternative was to add dependences in plugins/init.lua
  local notify = require "notify"

  local function show_notification(message, level)
    notify(message, level, { title = "conform.nvim" })
  end

  vim.api.nvim_create_user_command("FormatToggle", function(args)
    local is_global = not args.bang
    if is_global then
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      if vim.g.disable_autoformat then
        show_notification("Autoformat-on-save disabled globally", "info")
      else
        show_notification("Autoformat-on-save enabled globally", "info")
      end
    else
      vim.b.disable_autoformat = not vim.b.disable_autoformat
      if vim.b.disable_autoformat then
        show_notification("Autoformat-on-save disabled for this buffer", "info")
      else
        show_notification("Autoformat-on-save enabled for this buffer", "info")
      end
    end
  end, {
    desc = "Toggle autoformat-on-save",
    bang = true,
  })

  require("conform").setup(options)
end

return M

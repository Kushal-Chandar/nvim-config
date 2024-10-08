local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    markdown = { "prettier" },

    --web
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettier" },

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

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

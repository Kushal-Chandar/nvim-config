local M = {}

M.event = "BufWritePost" -- Automatically lint on file save

M.config = function()
  require("lint").linters_by_ft = {
    python = { "ruff" }, -- needs pyproject.toml
    lua = { "luacheck" },
    javascript = { "eslint" },
    typescript = { "eslint" },
    sh = { "shellcheck" },
    markdown = { "markdownlint-cli2" },
    toml = { "taplo" },
  }

  -- Auto-lint on file save
  vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
      require("lint").try_lint()
    end,
  })
end

return M

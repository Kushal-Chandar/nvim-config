local M = {}

M.config = function()
  local lspconfig = require "lspconfig"
  local nvlsp = require "nvchad.configs.lspconfig"

  -- nvlsp.defaults()
  -- don't load defaults for lua_ls, there is no way to extend settings
  -- below copy pasted defaults because i wanted to add settings
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()
  lspconfig.lua_ls.setup {
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
    on_init = nvlsp.on_init,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        -- had to add this for snippets
        completion = {
          callSnippet = "Replace",
          keywordSnippet = "Replace",
          showParams = true,
        },
      },
    },
  }
  -- defaults done

  -- EXAMPLE
  local servers = { "html", "cssls", "marksman" }

  -- lsps with default config
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end

  -- configuring single server, example: typescript
  -- lspconfig.ts_ls.setup {
  --   on_attach = nvlsp.on_attach,
  --   on_init = nvlsp.on_init,
  --   capabilities = nvlsp.capabilities,
  -- }

  lspconfig.powershell_es.setup {
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
  }
end

return M

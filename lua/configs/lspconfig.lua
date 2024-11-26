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

  local servers = { "html", "cssls", "marksman", "ruff", "rust_analyzer", "taplo" }

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

  -- ruff
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end
      if client.name == "ruff" then
        -- Disable hover in favor of Pyright
        client.server_capabilities.hoverProvider = false
      end
    end,
    desc = "LSP: Disable hover capability from Ruff",
  })

  -- pyright
  require("lspconfig").pyright.setup {
    settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { "*" },
        },
      },
    },
  }

  lspconfig.powershell_es.setup {
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
  }
end

return M

local M = {}

M.config = function()
  local lspconfig = require "lspconfig"
  local nvlsp = require "nvchad.configs.lspconfig"

  -- nvlsp.defaults()
  -- don't load defaults for lua_ls, there is no way to extend settings
  -- below copy pasted defaults because i wanted to add settings
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()
  -- Lua
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

  -- ESlint
  lspconfig.eslint.setup {
    on_attach = function(_, bufnr)
      -- fix all on format
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- CSS
  local tailwind_project_cache = nil
  local function is_tailwind_project()
    if tailwind_project_cache ~= nil then
      return tailwind_project_cache
    end

    local package_json_path = vim.fn.getcwd() .. "/package.json"

    if vim.fn.filereadable(package_json_path) == 1 then
      local success, data = pcall(vim.fn.json_decode, vim.fn.readfile(package_json_path, "n"))

      if success then
        tailwind_project_cache = data.dependencies and data.dependencies.tailwindcss
          or data.devDependencies and data.devDependencies.tailwindcss
        return tailwind_project_cache
      else
        vim.notify("Error parsing package.json for Tailwind CSS: " .. package_json_path, vim.log.levels.ERROR)
      end
    end
    tailwind_project_cache = false
    return false
  end
  (is_tailwind_project() and lspconfig.tailwindcss or lspconfig.cssls).setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Python
  -- Python.ruff
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

  -- Python.pyright
  lspconfig.pyright.setup {
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

  -- Powershell
  lspconfig.powershell_es.setup {
    bundle_path = vim.fn.stdpath "data" .. "/mason/packages/powershell-editor-services",
  }

  -- configuring single server, example: typescript
  -- lspconfig.ts_ls.setup {
  --   on_attach = nvlsp.on_attach,
  --   on_init = nvlsp.on_init,
  --   capabilities = nvlsp.capabilities,
  -- }

  -- servers with default configurations
  local default_servers = {
    "html",
    "marksman",
    "ruff",
    "rust_analyzer",
    "taplo",
    "clangd",
    "cmake",
    "emmet_language_server",
  }

  --clangd = ln -s /path/to/myproject/build/compile_commands.json /path/to/myproject/, link compile_commands.json to root of project

  -- lsps with default config
  for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end

return M

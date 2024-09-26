local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = { "html", "cssls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local function setup_compile_commands(root_pattern)
  local build_dir = "build"
  local compile_commands = "compile_commands.json"
  -- if vim.fn.isdirectory(build_dir) == 1 then
  --   if package.config:sub(1, 1) == '\\' then -- Windows
      print(string.format("mklink %s\\%s %s\\%s", root_pattern, compile_commands, build_dir, compile_commands))
  --   else                                     -- Unix-like
  --     os.execute(string.format("ln -sf %s/%s/%s %s/%s", root_pattern, build_dir, compile_commands,
  --       root_pattern, compile_commands))
  --   end
  --   print("Successfully created symbolic link to compile_commands.json")
  -- end
end

lspconfig.clangd.setup({
    on_attach = function(client, bufrn)
        on_attach(client, bufrn)
        -- Set up the compile_commands.json file symlink
        setup_compile_commands(client.config.root_dir)
    end
})


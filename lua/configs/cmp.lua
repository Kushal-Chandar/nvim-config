local M = {}

M.add_dependencies = {
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-cmdline",
  "onsails/lspkind.nvim",
}

M.config = function(_, opts)
  -- opts.sources[#opts.sources + 1] = { name = "codeium" }
  opts.experimental = { ghost_text = true }
  -- opts.completion = { completeopt = "menu,menuone,noselect" }

  opts.window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
      -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None",
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      side_padding = 0,
      col_offset = -1,
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None",
    },
  }
  opts.formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind =
        require("lspkind").cmp_format { mode = "symbol_text", maxwidth = 50, ellipsis_char = "..." }(entry, vim_item)
      local source = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[LUA]",
        buffer = "[BUF]",
        path = "[PATH]",
        luasnip = "[LSnip]",
        vsnip = "[VSnip]",
        ultisnips = "[USnip]",
        emoji = "[Emoji]",
        cmdline = "[CMD]",
      })[entry.source.name]

      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = strings[2] ~= nil and ("   " .. (strings[2] or "")) or ""
      kind.menu = source ~= nil and (kind.menu .. " - " .. source)

      -- set grey menu
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080" })
      return kind
    end,
  }

  -- for both search and commands completeopt don't auto select the first one
  local cmp = require "cmp"
  cmp.setup.cmdline("/", {
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      {
        name = "cmdline",
        option = {
          ignore_cmds = { "Man", "!" },
        },
      },
    }),
  })
  cmp.setup(opts)
end

return M

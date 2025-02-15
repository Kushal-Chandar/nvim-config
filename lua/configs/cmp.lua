local M = {}

M.add_dependencies = {
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-cmdline",
  "onsails/lspkind.nvim",
}

M.config = function(_, opts)
  -- opts.sources[#opts.sources + 1] = { name = "codeium" }
  opts.sources[#opts.sources + 1] = { name = "emoji" }
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
      local function overrides(entry_cp, vim_item_cp)
        if not entry_cp.completion_item.documentation or (type(entry_cp.completion_item.documentation) ~= "string") then
          return vim_item_cp
        end

        -- for tailwind css autocomplete colors
        if vim_item_cp.kind == "Color" then
          local hex_color = string.match(entry_cp.completion_item.documentation, "#(%x%x%x%x%x%x)")
          if hex_color then
            local group = "Tw_" .. hex_color
            if vim.fn.hlID(group) < 1 then
              vim.api.nvim_set_hl(0, group, { fg = "#" .. hex_color })
            end
            -- vim_item_cp.kind = "⬛" -- or "⬤" or anything
            vim_item_cp.kind_hl_group = group
            return vim_item_cp
          end
        end

        return vim_item_cp
      end

      local fmt = require("lspkind").cmp_format {
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        before = overrides,
      }(entry, vim_item)

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

      local strings = vim.split(fmt.kind, "%s", { trimempty = true })
      fmt.kind = " " .. (strings[1] or "") .. " "
      fmt.menu = strings[2] ~= nil and ("   " .. (strings[2] or "")) or ""
      fmt.menu = source ~= nil and (fmt.menu .. " - " .. source)

      -- set grey menu
      vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#808080" })
      return fmt
    end,
  }

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

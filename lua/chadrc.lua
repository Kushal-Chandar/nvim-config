-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

local utils = require "nvchad.stl.utils"

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chocolate",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.lsp = {
  signature = false, -- handled by noice
}

M.ui = {
  statusline = {
    theme = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "cwd" },
    modules = {
      cursor = "%#St_pos_sep#█%#St_pos_icon# %#St_pos_text# Ln %l, Col %c ",
      cwd = function()
        local icon = "%#St_cwd_icon#" .. "󰉋 "
        local name = vim.uv.cwd()
        name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
        return (vim.o.columns > 85 and ("%#St_cwd_sep#█" .. icon .. name)) or ""
      end,
      lsp = function()
        if rawget(vim, "lsp") then
          for _, client in ipairs(vim.lsp.get_clients()) do
            if client.attached_buffers[utils.stbufnr()] then
              return "%#St_Lsp#" .. ((vim.o.columns > 100 and "  " .. client.name .. " ") or "  ")
            end
          end
        end
        return ""
      end,
    },
  },
  -- cmp = {
  --   style = "atom_colored",
  --   icons = true,
  --   icons_left = false,
  --   format_colors = {
  --     tailwind = true,
  --   },
  -- },
}

M.term = {
  winopts = { signcolumn = "no" },
  sizes = { vsp = 0.4 },
}

M.colorify = {
  mode = "bg",
}

return M

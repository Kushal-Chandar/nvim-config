local M = {}

M.dependencies = {
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
}

local lsp_conf = {
  override = {
    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    ["vim.lsp.util.stylize_markdown"] = true,
    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  },
}

local presets_conf = {
  bottom_search = false, -- use a classic bottom cmdline for search
  command_palette = false, -- position the cmdline and popupmenu together
  long_message_to_split = true, -- long messages will be sent to a split
  inc_rename = true, -- enables an input dialog for inc-rename.nvim
  lsp_doc_border = true, -- add a border to hover docs and signature help
}

local routes_conf = {
  { filter = { event = "notify", find = "No information available" }, opts = { skip = true } },
  { filter = { event = "notify", find = "No signature help available" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
  { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
}

M.config = function()
  require("noice").setup { routes = routes_conf, lsp = lsp_conf, presets = presets_conf }
end

return M

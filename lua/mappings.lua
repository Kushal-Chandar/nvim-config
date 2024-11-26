require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Default overrides
map("n", "<leader>xx", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- Noice
map("n", "<leader>dn", "<cmd>NoiceDismiss<CR>", { desc = "NoiceDismiss" })

-- Conform
map("n", "<leader>tf", ":FormatToggle<CR>", { desc = "Toggle Autoformat Globally" })
map("n", "<leader>tb", ":FormatToggle!<CR>", { desc = "Toggle Autoformat for Buffer" })

-- IncRename
map("n", "<leader>ri", ":IncRename ", { desc = "Rename variable" })
map("n", "<leader>rc", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { desc = "Edit variable", expr = true })

-- Todo Comments
map("n", "<leader>[l", "<cmd>TodoLocList<cr>", { desc = "Show todoes in loc list" })
-- map("n", "<leader>[q", "<cmd>TodoQuickFix<cr>", { desc = "Show todos in quick fix list" })

-- TeleScope
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

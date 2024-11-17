require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Noice
map("n", "<leader>dn", "<cmd>NoiceDismiss<CR>", { desc = "NoiceDismiss" })

-- Conform 
map("n", "<leader>tf", ":FormatToggle<CR>", { desc = "Toggle Autoformat Globally" })
map("n", "<leader>tb", ":FormatToggle!<CR>", { desc = "Toggle Autoformat for Buffer" })

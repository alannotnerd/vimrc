-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<esc>", { silent = true })
vim.keymap.set("n", "<leader>ub", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle git line blames" })

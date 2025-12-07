-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Floating terminal toggle with Alt+i
vim.keymap.set({ "n", "t" }, "<A-i>", "<cmd>ToggleTerm direction=float<cr>", { silent = true })

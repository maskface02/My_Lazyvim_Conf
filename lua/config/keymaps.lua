-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Floating terminal toggle with Alt+i
vim.keymap.set({ "n", "t" }, "<A-i>", "<cmd>ToggleTerm direction=float<cr>", { silent = true })

-- Move current line up/down using Alt+Up/Down arrows
vim.keymap.set("n", "<A-Up>", ":move -2<CR>", { desc = "Move line up", silent = true })
vim.keymap.set("n", "<A-Down>", ":move +1<CR>", { desc = "Move line down", silent = true })

-- Visual mode selection moving
vim.keymap.set("v", "<A-Up>", ":move '<-2<CR>gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<A-Down>", ":move '>+1<CR>gv", { desc = "Move selection down", silent = true })

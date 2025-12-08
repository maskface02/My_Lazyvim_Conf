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

-- Tab completion for Copilot and LSP
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.keymap.set("i", "<Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  elseif vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return "<Tab>"
  elseif has_words_before() then
    return "<C-n>"
  else
    return "<Tab>"
  end
end, { expr = true, desc = "Tab completion for Copilot/LSP" })

vim.keymap.set("i", "<S-Tab>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept_prev()
  else
    return "<C-p>"
  end
end, { expr = true, desc = "Previous item in Copilot/LSP completion" })

vim.keymap.set("i", "<C-e>", function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").dismiss()
  end
  return "<C-e>"
end, { expr = true, desc = "Dismiss Copilot suggestion" })

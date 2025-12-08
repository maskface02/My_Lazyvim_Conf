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
  -- Use the newer copilot.lua API if available
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok and suggestion.is_visible() then
    return suggestion.accept()
  elseif vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return "<Tab>"
  else
    -- Check if we have LSP/completion candidates first
    local cmp_available, cmp = pcall(require, "cmp")
    local copilot_suggestion = pcall(require, "copilot.suggestion")
    local has_suggestions = copilot_suggestion and require("copilot.suggestion").is_visible()
    
    if cmp_available and cmp.visible() then
      return cmp.select_next_item()
    elseif has_words_before() then
      return "<C-n>"
    else
      -- Trigger the default tab behavior by calling the built-in function
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", false)
      return ""
    end
  end
end, { expr = true, desc = "Tab completion for Copilot/LSP" })

vim.keymap.set("i", "<S-Tab>", function()
  local cmp_available, cmp = pcall(require, "cmp")
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok and suggestion.is_visible() then
    return suggestion.accept_prev()
  elseif cmp_available and cmp.visible() then
    return cmp.select_prev_item()
  else
    -- Trigger the default Shift+Tab behavior by calling the built-in function
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", false)
    return ""
  end
end, { expr = true, desc = "Previous item in Copilot/LSP completion" })

vim.keymap.set("i", "<C-e>", function()
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok and suggestion.is_visible() then
    return suggestion.dismiss()
  else
    return "<C-e>"
  end
end, { expr = true, desc = "Dismiss Copilot suggestion" })

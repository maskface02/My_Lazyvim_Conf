return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      -- Remap VM keys to feel like VS Code:
      -- Ctrl+D = add next match
      -- Ctrl+Shift+D = add previous match (use Ctrl+U as a practical alternative)
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Select Cursor Down"] = "<M-Down>",
        ["Select Cursor Up"] = "<M-Up>",
        ["Skip Region"] = "<C-x>",
        ["Remove Region"] = "<C-p>", -- optional
      }
    end,
  },
}


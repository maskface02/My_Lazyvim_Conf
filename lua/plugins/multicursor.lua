return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Select Cursor Down"] = "<M-Down>",
        ["Select Cursor Up"] = "<M-Up>",
        ["Skip Region"] = "<C-x>",
        ["Remove Region"] = "<C-p>",
      }
    end,
    config = function()
      local grp = vim.api.nvim_create_augroup("VMCompletionFix", { clear = true })

      -- Optional: keep a copy of eventignore (some setups get stuck after VM)
      vim.api.nvim_create_autocmd("User", {
        group = grp,
        pattern = "visual_multi_start",
        callback = function()
          vim.b._vm_eventignore = vim.o.eventignore
        end,
      })

      -- Main fix: remove buffer-local insert maps that VM may leave behind,
      -- so your completion mappings work again.
      vim.api.nvim_create_autocmd("User", {
        group = grp,
        pattern = "visual_multi_exit",
        callback = function()
          if vim.b._vm_eventignore ~= nil then
            vim.o.eventignore = vim.b._vm_eventignore
            vim.b._vm_eventignore = nil
          end

          for _, lhs in ipairs({
            "<CR>",
            "<Tab>",
            "<S-Tab>",
            "<Up>",
            "<Down>",
            "<C-n>",
            "<C-p>",
            "<C-y>",
            "<C-e>",
            "<C-d>",
          }) do
            pcall(vim.keymap.del, "i", lhs, { buffer = 0 })
          end
        end,
      })
    end,
  },
}


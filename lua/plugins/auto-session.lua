return {
  "rmagatti/auto-session",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("auto-session").setup({ session_lens = { picker = "telescope" } })
    vim.keymap.set("n", "<leader>ls", "<cmd>AutoSession search<CR>", { noremap = true })
  end,
}


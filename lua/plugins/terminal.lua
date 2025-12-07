return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<A-i>]], -- Alt+i
        shade_terminals = true,
        direction = "float",
        float_opts = {
          border = "rounded",
          width = math.floor(vim.o.columns * 0.5),
          height = math.floor(vim.o.lines * 0.5),
        },
      })
    end,
  },
}


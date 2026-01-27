return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<A-i>]],
        shade_terminals = true,
        direction = "float",

        float_opts = {
          border = "rounded",

          width = function()
            return math.floor(vim.o.columns * 0.5)   -- medium width
          end,

          height = function()
            return math.floor(vim.o.lines * 0.5)    -- medium height
          end,
        },
      })
    end,
  },
}


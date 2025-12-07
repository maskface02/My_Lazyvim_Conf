-- lua/plugins/lsp.lua
return {
  -- Ensure clangd is installed and setup
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({})
    end,
  },
}

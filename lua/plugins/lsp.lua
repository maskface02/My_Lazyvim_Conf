-- lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {}, -- C / C++
        pyright = {}, -- Python
      },
    },
  },
}

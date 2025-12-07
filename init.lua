-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd([[colorscheme tokyonight]]) -- if you set a colorscheme
require("transparent").clear()
require("transparent").toggle() -- enable transparency

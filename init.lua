-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.cmd([[colorscheme tokyonight]]) -- if you set a colorscheme
require("transparent").clear()
require("transparent").toggle() -- enable transparency

-- Set up the 42 header plugin functionality
local setheader = require('plugins.Setheader')

-- Create the command
vim.api.nvim_create_user_command('Stdheader', function()
  setheader.add_header()
end, {})

-- Set up keymap for F1
vim.api.nvim_set_keymap('n', '<F1>', ':Stdheader<CR>', { noremap = true, silent = true })

-- Set up autocommand to update header on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    setheader.update_header()
  end,
})

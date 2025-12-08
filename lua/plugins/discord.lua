return {
  "andweeb/presence.nvim",
  event = "VeryLazy",
  config = function()
    require("presence").setup({
      -- General options
      auto_update         = true,           -- Update activity based on autocmd events
      neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image          = "neovim",       -- Main image display (either "neovim" or custom asset ID)
      client_id           = "749037646823981086", -- Use default Neovim client ID
      log_level           = nil,            -- Log messages at or above this level
      debounce_timeout    = 10,             -- Number of seconds to debounce activity updates
      enable_line_number  = false,          -- Displays the current line number instead of the current project
      blacklist           = {},             -- Functions to call against each buffer to determine if it should be filtered out
      buttons             = true,           -- Use buttons for rich presence
      file_assets         = {},             -- Custom file asset definitions
      show_time           = true,           -- Show the timer

      -- Rich Presence text options
      editing_text        = "Editing %s",   -- Format string for the "editing" status
      file_explorer_text  = "Browsing %s",  -- Format string for the "browsing files" status
      git_commit_text     = "Committing changes", -- Format string for the "committing" status
      plugin_manager_text = "Managing plugins", -- Format string for the "plugin manager" status
      reading_text        = "Reading %s",   -- Format string for the "reading" status
      workspace_text      = "Working on %s",-- Format string for the "workspace" status
      line_number_text    = "Line %s/%s",   -- Format string for the "line number" status
    })
  end,
}
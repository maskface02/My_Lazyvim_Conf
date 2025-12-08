return {
  -- GitHub Copilot core plugin
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-a>",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-e>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.0.0
        server_opts_overrides = {},
      })
    end,
  },

  -- Copilot Chat plugin
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      -- Setup CopilotChat with vertical split layout for chat window
      require("CopilotChat").setup({
        window = {
          layout = 'vertical',
          width = 40,           -- Fixed width for vertical split
          height = 0.8,         -- 80% of screen height
          direction = 'right',  -- Open chat on the right side (like vsplit)
          border = 'rounded',
          title = 'Copilot Chat',
        },
        debug = false, -- Disable debug messages
        silent = true, -- Make operations silent
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>cc", function()
        require("CopilotChat").open()
      end, { desc = "Open Copilot Chat in vertical split" })

      vim.keymap.set("v", "<leader>cx", function()
        require("CopilotChat").explain()
      end, { desc = "Explain selected code" })

      vim.keymap.set("v", "<leader>cl", function()
        require("CopilotChat").fix()
      end, { desc = "Fix code via Copilot" })
      
      -- Additional keymap for general correction
      vim.keymap.set("n", "<leader>cr", function()
        local input = vim.fn.input("Correct with Copilot: ")
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end, { desc = "Correct with Copilot" })
    end,
  },
}

return {
  -- GitHub Copilot core plugin
  {
    "github/copilot.vim",
    config = function()
      -- Configure Copilot to auto-start and handle authentication
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Set up autocommand to start Copilot when possible
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function()
          -- Only enable Copilot for supported file types
          if vim.bo.buftype == "" then
            vim.defer_fn(function()
              -- Attempt to start Copilot if not already running
              local copilot_status = vim.fn.system("copilot status 2>/dev/null")
              if string.find(copilot_status, "not enabled") or string.find(copilot_status, "not logged in") then
                -- Copilot needs authentication
                print("GitHub Copilot needs authentication. Run: gh auth login && gh copilot auth")
              end
            end, 1000)
          end
        end,
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
      -- Setup CopilotChat with tab layout for chat window
      require("CopilotChat").setup({
        window = {
          layout = "tab", -- Changed to "tab" to open in a new tab instead of floating window
        },
        debug = true, -- optional: helps with tracing errors
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>cc", function()
        require("CopilotChat").open()
      end, { desc = "Open Copilot Chat in new tab" })

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

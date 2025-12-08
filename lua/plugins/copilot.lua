return {
  -- GitHub Copilot core plugin
  {
    "github/copilot.vim",
    config = function()
      -- Configure Copilot to auto-start and handle authentication
      vim.g.copilot_no_tab_map = false  -- Enable Tab mapping for Copilot
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Set up autocommand to start Copilot when possible
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*" },
        callback = function()
          -- Only enable Copilot for supported file types
          if vim.bo.buftype == "" then
            vim.defer_fn(function()
              -- Check if gh CLI is installed
              local handle = io.popen("command -v gh")
              if not handle then
                print("GitHub CLI (gh) not found. Install it first: https://cli.github.com/")
                return
              end
              
              local result = handle:read("*a"):gsub("%s+", "")
              handle:close()
              
              if result == "" then
                print("GitHub CLI (gh) not found. Install it first: https://cli.github.com/")
                return
              end
              
              -- Check Copilot status using gh copilot command
              local copilot_handle = io.popen("gh copilot status 2>&1")
              if copilot_handle then
                local copilot_status = copilot_handle:read("*a")
                copilot_handle:close()
                
                -- Debug: print the exact status response
                -- print("Debug: Copilot status response: " .. copilot_status)
                
                -- Check if not authenticated or other issues
                if string.find(copilot_status, "not signed in") or 
                   string.find(copilot_status, "not logged in") or 
                   string.find(copilot_status, "run gh auth login") or
                   string.find(copilot_status, "exit code 1") then
                  print("GitHub Copilot needs authentication. Run: :!gh auth login && :!gh copilot auth")
                  print("Or run these commands in terminal: gh auth login && gh copilot auth")
                elseif string.find(copilot_status, "enabled") then
                  -- Copilot is ready, try starting it
                  pcall(vim.cmd, "Copilot")
                end
              else
                -- Fallback: try the original method
                local success, result = pcall(vim.fn.system, "copilot status 2>/dev/null")
                if success and (string.find(result, "not enabled") or string.find(result, "not logged in")) then
                  print("GitHub Copilot needs authentication. Run: :!gh auth login && :!gh copilot auth")
                end
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

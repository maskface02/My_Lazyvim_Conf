return {
  -- GitHub Copilot core plugin
  {
    "github/copilot.vim",
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
      -- Setup CopilotChat safely
      require("CopilotChat").setup({
        window = {
          layout = "float", -- safer than "tab", avoids 'Invalid name' error
        },
        debug = true, -- optional: helps with tracing errors
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>cc", function()
        require("CopilotChat").open()
      end, { desc = "Open Copilot Chat" })

      vim.keymap.set("v", "<leader>cx", function()
        require("CopilotChat").explain()
      end, { desc = "Explain selected code" })

      vim.keymap.set("v", "<leader>cl", function()
        require("CopilotChat").fix()
      end, { desc = "Fix code via Copilot" })
    end,
  },
}

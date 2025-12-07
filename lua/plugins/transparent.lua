-- lua/plugins/transparent.lua
return {
  {
    "xiyaowong/nvim-transparent",
    opts = {
      enable = true,
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "WhichKeyFloat",
        "CmpDoc",
        "CmpDocumentation",
        "FloatBorder",
        "TelescopeNormal",
        "TelescopeBorder",
        "StatusLine",
        "StatusLineNC",
      },
    },
    config = function(_, opts)
      -- try to setup the plugin if available
      pcall(function()
        local ok, transparent = pcall(require, "transparent")
        if ok and transparent and transparent.setup then
          transparent.setup(opts)
        end
      end)

      -- function that forces highlights to transparent (fallback + guaranteed)
      local function force_transparency()
        local groups = {
          "Normal", "NormalFloat", "SignColumn", "LineNr", "Folded", "NonText",
          "SpecialKey", "VertSplit", "EndOfBuffer", "CursorLineNr", "FloatBorder",
          "WinSeparator", "StatusLine", "StatusLineNC", "TelescopeNormal",
          "TelescopeBorder", "WhichKeyFloat", "NvimTreeNormal",
        }
        for _, group in ipairs(groups) do
          pcall(vim.api.nvim_set_hl, 0, group, { bg = "none" })
        end
      end

      -- ensure transparency after colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- prefer plugin API if present, else fallback to forcing highlights
          local ok, transparent = pcall(require, "transparent")
          if ok and transparent then
            if transparent.clear then pcall(transparent.clear) end
            if transparent.enable then pcall(transparent.enable) end
            -- some versions expose toggle — try that too
            if not transparent.enable and transparent.toggle then pcall(transparent.toggle, true) end
          else
            force_transparency()
          end
        end,
      })

      -- run at startup (safely)
      vim.schedule(function()
        local ok, transparent = pcall(require, "transparent")
        if ok and transparent then
          if transparent.clear then pcall(transparent.clear) end
          if transparent.enable then pcall(transparent.enable) end
          if not transparent.enable and transparent.toggle then pcall(transparent.toggle, true) end
        end
        -- always force highlights as well to be 100% sure
        force_transparency()
      end)
    end,
  },
}


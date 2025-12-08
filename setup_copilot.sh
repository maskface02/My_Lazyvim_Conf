#!/bin/bash

echo "GitHub Copilot Setup Script"
echo "============================="

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed."
    echo "Please install it first before running this script."
    exit 1
fi

echo "GitHub CLI is installed."

# Check if we're in an environment where we can authenticate
echo ""
echo "Before proceeding, you need to authenticate with GitHub."
echo "In most cases, you'll need to run: gh auth login"
echo "Then: gh extension install github/gh-copilot"
echo "Finally: gh copilot auth"
echo ""
echo "For headless environments (like remote servers), use: gh auth login --web"
echo ""
echo "After authentication, the Copilot plugins in Neovim will work properly."

# Check if the Copilot plugins are installed in the config
if [ -f "/workspace/lua/plugins/copilot.lua" ]; then
    echo ""
    echo "✓ Copilot plugin configuration found at /workspace/lua/plugins/copilot.lua"
    echo "  - Copilot Chat window is configured to open in a new buffer (replacing current buffer)"
    echo "  - Keymap <leader>cc opens Copilot Chat in new buffer"
    echo "  - Keymap <leader>cr for general corrections"
    echo "  - Alt+Up/Down arrow keys move lines up/down"
else
    echo "Warning: Copilot plugin configuration not found."
fi

echo ""
echo "After authentication, restart Neovim for all changes to take effect."
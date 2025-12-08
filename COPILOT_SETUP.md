# GitHub Copilot Setup Instructions

## Authentication Issues

The `copilot auth` command returning exit status 1 typically indicates that either:
1. GitHub CLI is not authenticated
2. Copilot CLI extension is not installed
3. The environment doesn't support GUI authentication flow

## Installation and Authentication Steps

### 1. Authenticate with GitHub CLI
```bash
gh auth login
```
Follow the prompts to authenticate using your preferred method.

### 2. Install Copilot Extension
```bash
gh extension install github/gh-copilot
```

### 3. Authenticate Copilot
```bash
gh copilot auth
```

## Configuration Changes Made

### Copilot Chat Window Layout
- Changed from floating window to tab layout (`layout = "tab"`)
- New keymap: `<leader>cc` opens Copilot Chat in a new tab
- Added correction keymap: `<leader>cr` for general corrections

### New Keymaps
- `<leader>cr` - Prompt for correction instruction and apply to buffer
- `<A-Up>` - Move current line up (Alt+Up arrow)
- `<A-Down>` - Move current line down (Alt+Down arrow)
- `<A-Up>` in visual mode - Move selected lines up
- `<A-Down>` in visual mode - Move selected lines down

## Troubleshooting Authentication

If you're in a headless environment (like a remote server or container):

1. **Use web-based authentication:**
   ```bash
   gh auth login --web
   ```

2. **Or generate a personal access token:**
   - Go to GitHub Settings > Developer settings > Personal access tokens
   - Create a new token with `copilot` scope
   - Set it as an environment variable:
   ```bash
   export GITHUB_TOKEN=<your_token_here>
   ```

3. **Check if Copilot service is running:**
   ```bash
   # Check status
   gh copilot status
   
   # Restart service if needed
   gh copilot restart
   ```
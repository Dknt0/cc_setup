#!/bin/sh

npm install -g @anthropic-ai/claude-code

# Add a API_KEY input here
echo "Please enter your API key:"
read -r API_KEY

# Set Z_AI_API_KEY environment variable in .bashrc or .zshrc according to the shell
SHELL_RC="$HOME/.bashrc"
if [ "$SHELL" = "/bin/zsh" ] || [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
fi
echo "export Z_AI_API_KEY=\"$API_KEY\"" >> "$SHELL_RC"
echo "Added Z_AI_API_KEY to $SHELL_RC"

# Fill the key in settings.json
sed -i "s/\"ANTHROPIC_AUTH_TOKEN\": \"\"/\"ANTHROPIC_AUTH_TOKEN\": \"$API_KEY\"/" settings.json
echo "Updated settings.json with API key"

# Move the json files to the correct location
mkdir -p "$HOME/.claude"
cp .claude.json "$HOME/.claude/settings.json"
echo "Copied .claude.json to ~/.claude/settings.json"


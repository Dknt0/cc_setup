#!/bin/sh

npm install -g @anthropic-ai/claude-code
npm install -g @zed-industries/claude-agent-acp

# Test if the variable is already set as an environment variable
if [ -n "$Z_AI_API_KEY" ]; then
  echo "Z_AI_API_KEY is already set as an environment variable. Skipping adding to $SHELL_RC."
  API_KEY="$Z_AI_API_KEY"
else
  # Set Z_AI_API_KEY environment variable in .bashrc or .zshrc according to the shell
  SHELL_RC="$HOME/.bashrc"
  if [ "$SHELL" = "/bin/zsh" ] || [ -f "$HOME/.zshrc" ]; then
      SHELL_RC="$HOME/.zshrc"
  fi
  echo "Please enter your API key:"
  read -r API_KEY
  echo "export Z_AI_API_KEY=$API_KEY" >> "$SHELL_RC"
  echo "Added Z_AI_API_KEY to $SHELL_RC"


# Move the json files to the correct location
mkdir -p "$HOME/.claude"
cp settings.json "$HOME/.claude/settings.json"
echo "Copied settings.json to ~/.claude/settings.json"

# Fill the key in settings.json
sed -i "s/\"ANTHROPIC_AUTH_TOKEN\": \"\"/\"ANTHROPIC_AUTH_TOKEN\": \"$API_KEY\"/" $HOME/.claude/settings.json
echo "Updated settings.json with API key"

cp .claude.json "$HOME/.claude.json"
echo "Copied .claude.json to ~/.claude.json"

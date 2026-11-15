#!/usr/bin/env bash
# Symlink dotfiles into $HOME. Works wherever this repo is cloned; re-run after moving it.
set -euo pipefail

DOTFILES=$(cd "$(dirname "$0")/.." && pwd)

# link <repo-relative src> <dest>: back up a real file/dir at dest, then symlink.
# -n: replace an existing symlink-to-dir instead of creating a link inside it.
link() {
  local src="$DOTFILES/$1" dest=$2
  [ -e "$src" ] || { echo "  skip $1 (missing)"; return 0; }
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.bak.$(date +%Y%m%d%H%M%S)"
    echo "  backed up existing $dest"
  fi
  ln -sfn "$src" "$dest"
  echo "  $dest -> $src"
}

echo "Symlinking dotfiles from $DOTFILES"

echo "git"
link git/.gitconfig        ~/.gitconfig
link git/.gitignore_global ~/.gitignore_global

echo "inputrc"
link config/.inputrc ~/.inputrc

echo "neovim"
link config/nvim/init.lua          ~/.config/nvim/init.lua
link config/nvim/lua               ~/.config/nvim/lua
link config/nvim/colors            ~/.config/nvim/colors
link config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

echo "ghostty"
# ~/.config/ghostty works on macOS and Linux. On macOS Ghostty also reads
# ~/Library/Application Support/com.mitchellh.ghostty/config(.ghostty) afterwards,
# so anything set there overrides this file.
link config/ghostty/config ~/.config/ghostty/config

echo "zsh"
# .env_variables holds machine-local secrets: copy once, never overwrite
if [ ! -e ~/.env_variables ]; then
  cp -p "$DOTFILES/zsh/.env_variables" ~/
  echo "  copied ~/.env_variables"
fi
link zsh/.zshrc ~/.zshrc

echo "tmux"
link tmux/.tmux.conf ~/.tmux.conf
# note: manually set execution permission for the following files
link tmux/dev_env     ~/dev_env
link tmux/lixibox_env ~/lixibox_env

echo "ws (git worktree + tmux task manager)"
link ws/ws ~/.local/bin/ws

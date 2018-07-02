echo -e "\n\nCopy config file..."
echo "=============================="

echo "symlink gitcofig and gitignore_global"
ln -s -f ~/works/dotfiles/git/.gitconfig ~/.gitconfig
ln -s -f ~/works/dotfiles/git/.gitignore_global ~/.gitignore_global

echo "symlink inputrc config file"
ln -s -f ~/works/dotfiles/config/.inputrc ~/.inputrc

echo "symlink neovim config"
if [ ! -d "~/.config/nvim" ]; then
  mkdir -p ~/.config/nvim
fi
ln -s -f ~/works/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim

echo "symlink zsh config"
ln -s -f ~/works/dotfiles/zsh/.zshrc ~/.zshrc

echo "symlink tmux config"
ln -s -f ~/works/dotfiles/tmux/.tmux.conf ~/.tmux.conf

echo "symlink tmux config environment"
# note: manually set excution permission for the following files
ln -s -f ~/works/dotfiles/tmux/dev_env ~/dev_env
ln -s -f ~/works/dotfiles/tmux/lixibox_env ~/lixibox_env


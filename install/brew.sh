#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\n\nInstalling homebrew packages..."
echo "=============================="

formulas=(
    # flags should pass through the the `brew list check`
    ack
    diff-so-fancy
    fzf
    git
    highlight
    markdown
    neovim/neovim/neovim
    the_silver_searcher
    zsh
    zsh-completions
    zsh-autosuggestions
    tmux
    reattach-to-user-namespace
    wget
    ctags
    python3
    imagemagick

    mysql
    redis
    elasticsearch
)

for formula in "${formulas[@]}"; do
    if brew list "$formula" > /dev/null 2>&1; then
        echo "$formula already installed... skipping."
    else
        brew install $formula
    fi
    echo -e "\n\n"
done

echo "Start mysql service"
brew services start mysql

echo "installing neovim"
pip3 install neovim

echo "installing java"
brew cask install java

echo "installing Oh My Zsh via wget"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


echo -e "\n\nCopy config file..."
echo "=============================="

echo "symlink gitcofig and gitignore_global"
ln -s -f ../git/.gitconfig ~/.gitconfig
ln -s -f ../git/.gitignore_global ~/.gitignore_global

echo "symlink inputrc config file"
ln -s -f ..config/.inputrc ~/.inputrc

echo "symlink neovim config"
if [ ! -d "~/.config/nvim" ]; then
  mkdir -p ~/.config/nvim
fi
ln -s -f ../config/nvim/init.vim ~/.config/nvim/init.vim

echo "symlink zsh config"
ln -s -f ../zsh/.zshrc ~/.zshrc

echo "symlink tmux config"
ln -s -f ../tmux/.tmux.conf ~/.tmux.conf

echo "symlink tmux config environment"
# note: manually set excution permission for the following files
ln -s -f ../tmux/dev_env ~/dev_env
ln -s -f ../tmux/lixibox_env ~/lixibox_env


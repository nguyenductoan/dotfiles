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

echo "installing Oh My Zsh via wget"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


echo -e "\n\nCopy config file..."
echo "=============================="

echo "copy gitcofig to root directory"
cp ../git/.gitconfig ~/

echo "copy inputrc config file"
cp ..config/.inputrc ~/

echo "copy neovim config to root directory"
if [ ! -d "~/.config/nvim" ]; then
  mkdir -p ~/.config/nvim
fi
cp ../config/nvim/init.vim ~/.config/nvim/

echo "copy zsh config to root directory"
cp ../zsh/.zshrc ~/

echo "copy tmux config to root directory"
cp ../tmux/.tmux.conf ~/

echo "copy tmux config environment to root directory"
cp ../tmux/general-dev ~/
cp ../tmux/lixibox-dev ~/


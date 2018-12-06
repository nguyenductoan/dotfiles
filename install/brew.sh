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
    zsh-history-substring-search
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

echo "alias ctags (ref: http://www.gmarik.info/blog/2010/ctags-on-OSX/)
alias ctags="`brew --prefix`/bin/ctags"


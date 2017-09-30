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

pip3 install neovim

echo "copy gitcofig to root directory"
cp ~/dotfiles/git/.gitconfig ~/

echo "copy neovim config to root directory"
cp ~/dotfiles/config/nvim/init.vim ~/

echo "copy zsh config to root directory"
cp ~/dotfiles/zsh/.zshrc ~/

echo "copy tmux config to root directory"
cp ~/dotfiles/tmux/.tmux.conf ~/

echo "install Oh My Zsh via wget"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


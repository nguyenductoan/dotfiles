DISABLE_AUTO_UPDATE=true

# OS detection
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export ZSH=/home/$USER/.oh-my-zsh

  # NVM
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  # Keychain
  /usr/bin/keychain $HOME/.ssh/personal_id_rsa
  source $HOME/.keychain/$(hostname)-sh

  # IBus input method
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
  export XMODIFIERS=@im=ibus
  export QT4_IM_MODULE=ibus
  export CLUTTER_IM_MODULE=ibus
  export GLFW_IM_MODULE=ibus

  # Conda
  __conda_setup="$('/home/ndt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "/home/ndt/anaconda3/etc/profile.d/conda.sh" ]; then
      . "/home/ndt/anaconda3/etc/profile.d/conda.sh"
    else
      export PATH="/home/ndt/anaconda3/bin:$PATH"
    fi
  fi
  unset __conda_setup

elif [[ "$OSTYPE" == "darwin"* ]]; then
  export ZSH=/Users/$USER/.oh-my-zsh
  export PATH=/opt/homebrew/bin:$PATH
  export PATH=/Users/$USER/Library/Python/3.8/bin:$PATH
else
  echo 'Unknown OS!'
fi

# Editor
export EDITOR="nvim"
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write immediately, not on shell exit
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first when trimming
setopt HIST_IGNORE_ALL_DUPS      # Delete old entry if new entry is a duplicate
setopt SHARE_HISTORY             # Share history between all sessions

# oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git tmux zsh-completions vi-mode history-substring-search fzf docker-compose kubectl asdf kube-ps1)

source $HOME/.cargo/env
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt
KUBE_PS1_SYMBOL_ENABLE=false
NEWLINE=$'\n'
ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='%{$fg[green]%}%* |%{$fg[green]%}%p %{$fg[cyan]%}%c %{$fg[blue]%}$(git_prompt_info)%{$fg[blue]%}$(kube_ps1) ${NEWLINE}${ret_status} %{$reset_color%}'

# Key bindings
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git, node_modules}"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER=''
bindkey '^I' $fzf_default_completion
bindkey '^T' fzf-completion

# Go
export GOPATH=$HOME/go-workspace
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin

# PATH — consolidated
export PATH=$GOROOT/bin:$GOBIN:$PATH
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.local/bin"

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# npm/yarn
export PATH=$(npm get prefix)/bin:$PATH

# Misc
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export NODE_EXTRA_CA_CERTS="$HOME/.certs/nscacert.pem"

# Aliases
alias heroku_pe='heroku accounts:set personal'
alias heroku_eh='heroku accounts:set eh'

# Fuzzy git branch checkout — no args opens fzf picker, args pass through to git checkout
# unalias the 'gco' of oh-my-zsh git plugin
unalias gco 2>/dev/null
function gco() {
  if [ $# -eq 0 ]; then
    local branch
    branch=$(git branch -a | grep -v HEAD | sed 's|remotes/origin/||' | sort -u | fzf \
      --height 40% --reverse \
      --preview 'b=$(echo {} | tr -d " *"); git log --oneline --color=always -20 "$b" 2>/dev/null || git log --oneline --color=always -20 "origin/$b" 2>/dev/null') \
    && git checkout "$(echo "$branch" | tr -d ' *')"
  else
    git checkout "$@"
  fi
}

# Fuzzy git branch delete — tab to multi-select, uses -D to force
function gbdf() {
  local branches
  branches=$(git branch | grep -v '^\*' | fzf --multi --height 40% --reverse \
    --preview 'git log --oneline --color=always -20 $(echo {} | tr -d " ")') \
  && echo "$branches" | tr -d ' ' | xargs git branch -D
}

# Claude Code — connect to Neovim whose cwd matches the current directory
# Named 'my-claude-code' to avoid shadowing the system C compiler (cc -> clang)
function my-claude-code() {
  local dir_name="${PWD:t}"
  local ide_dir="$HOME/.claude/ide"
  local -a port_files
  port_files=("${ide_dir}"/nvim_${dir_name}_<->\.port(N))   # glob: <-> matches integers

  if (( ${#port_files} == 0 )); then
    print "cc: no Neovim port file found for directory '${dir_name}' — starting Claude without IDE connection" >&2
    claude "$@"
  elif (( ${#port_files} == 1 )); then
    CLAUDE_CODE_SSE_PORT=$(< "${port_files[1]}") claude "$@"
  else
    # Multiple instances — let user pick with arrow keys
    local chosen
    chosen=$(printf '%s\n' "${port_files[@]}" | fzf \
      --prompt="Select Neovim session> " \
      --height=~10 \
      --layout=reverse \
      --no-info \
      --bind 'enter:accept')
    if [[ -z "$chosen" ]]; then
      print "cc: no selection made — starting Claude without IDE connection" >&2
      claude "$@"
    else
      CLAUDE_CODE_SSE_PORT=$(< "$chosen") claude "$@"
    fi
  fi
}

# Environment variables and secrets
if [ -f ~/.env_variables ]; then
  source ~/.env_variables
else
  print "404: ~/.env_variables not found."
fi

# Aliases file
if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
else
  print "404: ~/.zsh_aliases not found."
fi

# Prevent terminal resize (e.g. tmux zoom) from eating the last output line.
# ZLE miscounts prompt height by 1 when the prompt wraps, so it moves the cursor
# up one row too many on SIGWINCH. The blank line is sacrificed instead of real output.
function _precmd_blank_line() { echo }
add-zsh-hook precmd _precmd_blank_line

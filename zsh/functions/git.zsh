# Fuzzy git helpers (need fzf). Loaded from zsh/.zshrc after oh-my-zsh.

# gco [args...] — fuzzy git branch checkout.
#   gco                 fzf picker over local branches: current branch first, then most
#                       recently committed; preview shows the branch's last 20 commits
#   gco <args...>       plain `git checkout <args...>`
# Replaces the oh-my-zsh git plugin's `gco` alias, so this must load after oh-my-zsh.
unalias gco 2>/dev/null
function gco() {
  if [ $# -eq 0 ]; then
    local branch
    branch=$({ git branch --show-current | sed 's/^/* /'; git branch --sort=-committerdate | grep -v '^\*'; } | fzf \
      --height 40% --reverse \
      --preview 'b=$(echo {} | tr -d " *"); git log --oneline --color=always -20 "$b" 2>/dev/null') \
    && git checkout "$(echo "$branch" | tr -d ' *')"
  else
    git checkout "$@"
  fi
}

# gbdf — fuzzy git branch delete.
# fzf picker over local branches except the current one; Tab to multi-select.
# Force-deletes (git branch -D), so unmerged work on those branches is lost.
function gbdf() {
  local branches
  branches=$(git branch | grep -v '^\*' | fzf --multi --height 40% --reverse \
    --preview 'git log --oneline --color=always -20 $(echo {} | tr -d " ")') \
  && echo "$branches" | tr -d ' ' | xargs git branch -D
}

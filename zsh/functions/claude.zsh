# Claude Code helpers. Loaded from zsh/.zshrc.

# my-claude-code [claude args...] — start Claude Code connected to the Neovim
# (claudecode.nvim) running in a folder with the same name as the current one.
#   - Looks for ~/.claude/ide/nvim_<folder-name>_<port>.port files.
#   - None found: starts plain `claude` without an IDE connection.
#   - One found: connects to it via CLAUDE_CODE_SSE_PORT.
#   - Several (multiple nvim instances): fzf picker to choose one.
# All arguments are passed through to `claude`.
# Named 'my-claude-code' to avoid shadowing the system C compiler (cc -> clang).
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

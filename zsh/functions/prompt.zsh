# Prompt helpers. Loaded from zsh/.zshrc after oh-my-zsh.

# aws_prompt_info — prompt segment " (aws:<profile>)" shown when $AWS_PROFILE is set.
# Used by PROMPT in .zshrc; replaces the oh-my-zsh aws plugin's version, which
# also prints the region. Prints nothing when no profile is active.
function aws_prompt_info() {
  [[ -n "$AWS_PROFILE" ]] && echo " (%{$fg[blue]%}aws:%{$fg[cyan]%}$AWS_PROFILE%{$fg[blue]%})"
}

# _precmd_blank_line — print an empty line before every prompt.
# Prevents terminal resize (e.g. tmux zoom) from eating the last output line:
# ZLE miscounts prompt height by 1 when the prompt wraps, so it moves the cursor
# up one row too many on SIGWINCH. The blank line is sacrificed instead of real output.
function _precmd_blank_line() { echo }
add-zsh-hook precmd _precmd_blank_line

# ws: parallel tasks with git worktrees + tmux

Each task gets its own git worktree and its own tmux window, so several Claude Code sessions can work on the same repo without overwriting each other's files. `ws` only sets up the folder and the window. You start nvim, Claude, etc. yourself.

```
session my-app                         ← one tmux session per repo
 ├─ window main          shell         ← main checkout
 ├─ window add-login     shell         ← one git worktree per task
 └─ window fix-typo      shell
session my-api
 └─ window main          shell
```

- Main checkout: `<parent>/<repo>` (e.g. `~/code/my-app`)
- Task worktrees: `<parent>/<repo>.worktrees/<branch-slug>` (e.g. `~/code/my-app.worktrees/add-login`). Slashes and dots in branch names become `-` and `_`: `feature/a.b` → `feature-a_b`.
- Window name = branch slug. A new window opens with one shell pane already in the worktree folder.

## Install

`install/symlink.sh` links the script onto your PATH, wherever the dotfiles repo is cloned. Re-run it if you move the repo.

```bash
# done by install/symlink.sh (~/.local/bin is on PATH via zsh/.zshrc)
ln -sf "<dotfiles>/ws/ws" ~/.local/bin/ws
```

```tmux
# tmux/.tmux.conf: use the symlink path, since popups may not have ~/.local/bin on PATH
bind W display-popup -E -w 80% -h 60% -d "#{pane_current_path}" "~/.local/bin/ws open"
bind N command-prompt -p "new task branch:" "display-popup -E -w 80% -h 60% -d '#{pane_current_path}' '~/.local/bin/ws new %1'"
```

Requires: git, tmux ≥ 3.2 (popups), fzf (for the `ws open` picker), bash 3.2+.

## Usage

```
ws new <branch> [base]   Create a worktree and branch, open an empty task window
ws open [branch]         Switch to a task window, recreating it if closed (fzf picker if no branch)
ws ls                    List worktrees
ws rm [-f] [branch]      Remove worktree, ask before deleting branch, close window
```

`ws` works from the main checkout or from any of its worktrees.

### Examples

```bash
ws new add-login                   # new branch from origin's default branch (fetches first)
ws new hotfix origin/release       # new branch from another base
ws new someone/feature-x           # check out an existing local/remote branch (e.g. to review it)
ws open                            # fzf picker with git status + log preview
ws open add-login                  # jump to the task window
ws open main                       # window for the main checkout
ws rm                              # inside a task window: finish that task
ws rm -f hotfix                    # force-remove even with uncommitted changes
```

### tmux keys

| Keys | Action |
|---|---|
| `prefix + N` | New task (asks for a branch name) |
| `prefix + W` | Task picker |
| `prefix + <n>` | Switch task (window) |
| `prefix + l` | Session (repo) picker; `→` expands a session's windows |
| `prefix + j` / `prefix + k` | Next / previous repo |

## Day-to-day flow

1. `cd ~/code/my-app && ws open main`. This creates the repo's tmux session (once).
2. New task: `prefix + N` → `add-login`. It fetches, creates the branch and worktree, copies env files, runs setup, then switches you to the new window.
3. Start your tools in that window:
   ```bash
   prefix + |             # split; keeps the worktree folder
   nvim                   # left pane
   claude --ide           # right pane (or `claude`, then /ide)
   ```
   Claude pairs with this window's nvim (claudecode.nvim) because both run in the same worktree folder.
4. Start more tasks the same way. They run in parallel, each in its own folder and branch.
5. Hop between tasks with `prefix + <n>` or `prefix + W`, and between repos with `prefix + l`.
6. Coming back to a task: `ws open <branch>`, then `claude --continue --ide` to resume that folder's last conversation.
7. After the PR is merged, run `ws rm` in that window. It refuses if the worktree has uncommitted changes, removes it, asks before deleting the branch, and closes the window.

## Per-repo hooks (optional)

For each hook, the first file found wins: repo root, then `~/.config/ws/`. If you put them in the repo root, add them to `.git/info/exclude`.

```bash
# ~/.config/ws/<repo>.include  (or <repo>/.worktreeinclude)
# gitignored files/globs to copy from the main checkout into each new worktree
.env
.env.local
config/master.key
config/credentials/*.key

# ~/.config/ws/<repo>.setup  (or <repo>/.worktree-setup)
# runs inside the new worktree right after creation; $WS_ROOT = main checkout
bundle install --quiet
yarn install --frozen-lockfile
```

If setup fails, `ws` prints a warning and still opens the window.

## Things to watch

- **Shared dev DB:** all worktrees hit the same database. Run migrations in one task at a time, or set a different `DATABASE_URL` per worktree in its `.env`.
- **Ports:** give each worktree its own `PORT` if several run servers.
- **Claude folder trust:** Claude asks you to trust each new worktree folder the first time it starts there.
- **Same branch twice:** git won't check out one branch in two worktrees. Use `ws open` for a task that already exists.

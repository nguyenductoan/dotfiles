vim.loader.enable()

-- ===================== Bootstrap lazy.nvim =====================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader before lazy so mappings are correct
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- Disable netrw (nvim-tree takes over)
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- ===================== Plugins =====================
require("lazy").setup({
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        filters = { dotfiles = false },
        renderer = {
          root_folder_label = function(path)
            local width = vim.api.nvim_win_get_width(0) - 2
            if #path > width then
              return "…" .. path:sub(-(width - 1))
            end
            return path
          end,
          icons = {
            glyphs = {
              folder = {
                arrow_open   = "▼",
                arrow_closed = "▷",
              },
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>ls", "<cmd>NvimTreeToggle<CR>",   silent = true, desc = "Toggle file tree" },
      { "<leader>y",  "<cmd>NvimTreeFindFile<CR>", silent = true, desc = "Find file in tree" },
    },
  },
  "preservim/nerdcommenter",

  -- Git
  "tpope/vim-fugitive",
  {
    "linrongbin16/gitlinker.nvim",
    cmd  = "GitLink",
    keys = {
      { "<Leader>go",  "<cmd>GitLink!<CR>", mode = { "n", "v" }, desc = "Open in browser" },
      { "<Leader>gy",  "<cmd>GitLink<CR>",  mode = { "n", "v" }, desc = "Copy git link" },
    },
    config = function()
      local routers = require("gitlinker.routers")
      require("gitlinker").setup({
        router = {
          browse = {
            ["^ssh%.github%.com"] = function(lk)
              lk.host = "github.com"
              return routers.github_browse(lk)
            end,
          },
          blame = {
            ["^ssh%.github%.com"] = function(lk)
              lk.host = "github.com"
              return routers.github_blame_browse(lk)
            end,
          },
        },
      })
    end,
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewFocusFiles", "DiffviewToggleFiles" },
    opts = {
      enhanced_diff_hl = true,
      hooks = {
        view_opened = function()
          local ok, api = pcall(require, "nvim-tree.api")
          if ok then api.tree.close() end
        end,
        view_closed = function()
          local ok, api = pcall(require, "nvim-tree.api")
          if ok then api.tree.open() end
        end,
        diff_buf_read = function(bufnr)
          vim.opt_local.list              = false
          vim.opt_local.wrap              = true
          vim.b[bufnr].indentLine_enabled = 0
        end,
      },
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Repo history" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>",         desc = "Close diff view" },
    },
  },

  -- Ruby
  { "tpope/vim-bundler", ft = { "ruby", "eruby", "gemspec" } },
  { "tpope/vim-endwise", ft = { "ruby", "eruby", "lua", "vim" } },

  -- Editing helpers
  "tpope/vim-surround",
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  "mg979/vim-visual-multi",
  "easymotion/vim-easymotion",
  "rhysd/clever-f.vim",
  "ntpeters/vim-better-whitespace",
  "Yggdroot/indentLine",
  "mattn/emmet-vim",

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme                = "auto",
          section_separators   = "",
          component_separators = "|",
          globalstatus         = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "filetype" },
          lualine_y = {},
          lualine_z = { "%l/%L : %c" },
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          width  = 0.95,
          height = 0.85,
          row    = 0.5,
          preview = {
            layout     = "horizontal",
            horizontal = "right:50%",
          },
        },
        files = {
          formatter  = "path.filename_first",
          git_icons  = true,
          fd_opts    = "--color=never --type f --hidden --follow --exclude .git",
        },
        grep = {
          rg_opts    = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git'",
          actions    = {
            ["ctrl-q"] = { require("fzf-lua.actions").file_sel_to_qf, require("fzf-lua.actions").file_edit },
          },
        },
      })
    end,
  },

  -- Keybinding hints
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },

  -- Languages / Syntax
  "pangloss/vim-javascript",
  "kchmck/vim-coffee-script",
  "Glench/Vim-Jinja2-Syntax",
  "tomlion/vim-solidity",
  "hashivim/vim-terraform",
  { "fatih/vim-go", build = ":GoInstallBinaries", ft = "go" },

  -- LSP / COC
  -- Note: install coc-highlight extension via :CocInstall coc-highlight
  { "neoclide/coc.nvim", branch = "release" },

  -- Formatting
  "prettier/vim-prettier",

  -- Tags
  { "majutsushi/tagbar", cmd = "TagbarToggle" },

  -- Navigation
  "christoomey/vim-tmux-navigator",

  -- Terminal
  "mklabs/split-term.vim",

  -- Session
  "tpope/vim-obsession",

  -- Copilot
  "github/copilot.vim",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    opts = {
      diff_opts = {
        open_in_new_tab = true,
        hide_terminal_in_new_tab = true,
      },
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  -- Colorschemes
  "EdenEast/nightfox.nvim",
  "Rigellute/rigel",
})

-- ===================== VIM SETTINGS =====================
vim.opt.expandtab      = true
vim.opt.tabstop        = 2
vim.opt.shiftwidth     = 2
vim.opt.softtabstop    = 2
vim.opt.smartindent    = true
vim.opt.hlsearch       = true
vim.opt.incsearch      = true
vim.opt.copyindent     = true
vim.opt.ruler          = true
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.autoread      = true
vim.opt.backspace     = "indent,eol,start"
vim.opt.scrolloff     = 5
vim.opt.wrap          = true
vim.opt.foldmethod    = "indent"
vim.opt.foldlevelstart = 20
vim.opt.wildmenu      = true
vim.opt.wildmode      = "longest:list,full"
vim.opt.timeoutlen    = 500
vim.opt.ttimeoutlen   = 0
vim.opt.clipboard     = "unnamed,unnamedplus"
vim.opt.splitright    = true
vim.opt.splitbelow    = true
vim.opt.background    = "dark"
vim.opt.cmdheight     = 1
vim.opt.updatetime    = 300
vim.opt.signcolumn    = "yes"
vim.opt.termguicolors = true
vim.opt.re            = 0
vim.opt.list          = true
vim.opt.showbreak     = "↪"
vim.opt.titlestring   = "%t%( %M%)%( (%{expand(\"%:p:h\")})%)%( %a%) - %{v:servername}"

vim.opt.listchars = { tab = "\\. ", eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" }
vim.opt.fillchars:append({ vert = "|", diff = "╱" })
vim.opt.shortmess:append("c")

-- disable bell
vim.opt.errorbells  = false
vim.opt.visualbell  = true
vim.cmd("set t_vb=")

vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- Syntax / colorscheme / highlights
vim.cmd([[
  syntax on
  syntax enable
  colorscheme nguyenductoan

  hi VertSplit guibg=NONE cterm=NONE
  hi CursorLine term=bold cterm=bold guibg=Grey40
  highlight ColorColumn cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40
  hi SignColumn ctermbg=NONE
  highlight Visual cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40
  highlight Search cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40

  hi DiffAdd    ctermfg=231 ctermbg=22  cterm=NONE guifg=NONE   guibg=#1e3a2a
  hi DiffChange ctermfg=231 ctermbg=0   cterm=NONE guifg=NONE   guibg=#1a2a3a
  hi DiffDelete ctermfg=196 ctermbg=88  cterm=NONE guifg=#ff5555 guibg=#3a1a1a
  hi DiffText   ctermfg=16  ctermbg=214 cterm=NONE guifg=NONE   guibg=#4a3800
  hi Folded ctermbg=230 ctermfg=166

  highlight NonText guifg=#4a4a59
  highlight SpecialKey guifg=#4a4a59

  hi link NvimTreeNormal        Normal
  hi link NvimTreeEndOfBuffer   NonText
  hi link NvimTreeCursorLine    CursorLine
  hi link NvimTreeFolderName    Directory
  hi link NvimTreeOpenedFolderName Directory
  hi link NvimTreeRootFolder    Identifier

]])

-- Autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*.hamlc",
  command = "set ft=haml",
})

vim.api.nvim_create_autocmd("CursorHold", {
  group = augroup,
  pattern = "*",
  command = "checktime",
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = augroup,
  pattern = "*",
  command = "silent! !",
})

-- Write claudecode.nvim WebSocket port to a tmux-window-keyed file so the
-- `cc` shell function can connect the right Claude Code session to this Neovim.
local function tmux_window_id()
  if not os.getenv("TMUX") then return "default" end
  local id = vim.fn.system("tmux display-message -p '#{window_id}'"):gsub("%s+", "")
  return id ~= "" and id or "default"
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = function()
    vim.defer_fn(function()
      local ok, server = pcall(require, "claudecode.server.init")
      if ok and server.state and server.state.port then
        local path = vim.fn.expand("~/.claude/ide/nvim_" .. tmux_window_id() .. ".port")
        local f = io.open(path, "w")
        if f then f:write(tostring(server.state.port)); f:close() end
      end
    end, 1000)
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = augroup,
  callback = function()
    os.remove(vim.fn.expand("~/.claude/ide/nvim_" .. tmux_window_id() .. ".port"))
  end,
})

-- ===================== KEY MAPPINGS =====================
local map = vim.keymap.set

-- Escape
map("i", "jk", "<esc>")

-- Scroll faster
map("n", "<C-e>", "3<C-e>")
map("n", "<C-y>", "3<C-y>")

-- New tab
map("n", "<C-t>", ":tabnew<CR>", { silent = true })

-- Tmux navigator (must be set before plugin loads)
vim.g.tmux_navigator_no_mappings = 1
map("n", "<C-h>", ":TmuxNavigateLeft<CR>",  { silent = true })
map("n", "<C-j>", ":TmuxNavigateDown<CR>",  { silent = true })
map("n", "<C-k>", ":TmuxNavigateUp<CR>",    { silent = true })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })

-- Save / Quit / Edit
map("", "<Leader>w", ":w<CR>")
map("", "<Leader>q", ":q<CR>")
map("", "<Leader>e", ":e<CR>")

-- Select all
map("", "<C-s>", "<ESC>gg<S-v>G")

-- System clipboard copy/paste
map("v", "<Leader>y", '"+y')
map("v", "<Leader>d", '"+d')
map("n", "<Leader>p", '"+p')
map("n", "<Leader>P", '"+P')
map("v", "<Leader>p", '"+p')
map("v", "<Leader>P", '"+P')

-- Resize pane
map("n", "+", ":vertical resize +5<CR>")
map("n", "_", ":vertical resize -5<CR>")

-- Folding
map("n", "<Leader>z", "za")

-- Paste multiple times
map("x", "p", "pgvy")

-- Indentation in visual mode
map("v", "<TAB>",   ">gv")
map("v", "<S-TAB>", "<gv")

-- Vertical split
map("n", "<Leader>i", ":vsplit<CR>")

-- Close all buffers
map("", "<leader>ba", ":bufdo bd<CR>")

-- Move to beginning / end of line
map("n", "B", "^")
map("n", "E", "$")

-- Exit terminal mode
map("t", "jk", "<C-\\><C-n>")

-- Copy path variants to clipboard
map("n", "yp", ':let @+=expand("%")<CR>',     { silent = true })
map("n", "yP", ':let @+=expand("%:p")<CR>',   { silent = true })
map("n", "yf", ':let @+=expand("%:t")<CR>',   { silent = true })
map("n", "yd", ':let @+=expand("%:p:h")<CR>', { silent = true })

map("", "<C-c>", '"+y<CR>')

-- Tag update helpers
map("", "<leader>urt", "<ESC>:call Update_ruby_tags()<CR>",  { silent = true })
map("", "<leader>upt", "<ESC>:call Update_python_tags()<CR>", { silent = true })

-- ===================== PLUGIN SETTINGS =====================

-- Silver Searcher
if vim.fn.executable("ag") == 1 then
  vim.opt.grepprg = "ag --nogroup --nocolor"
end

-- Fugitive
map("n", "<Leader>ga",  ":Gwrite<CR>")
map("n", "<Leader>gc",  ":Gcommit -v<CR>")
map("n", "<Leader>gsh", ":Gpush<CR>")
map("n", "<Leader>gll", ":Gpull<CR>")
map("n", "<Leader>gs",  ":Gstatus<CR>")
map("n", "<Leader>gb",  ":Git blame<CR>")
--map("n", "<Leader>gd",  ":Gvdiff<CR>")
map("n", "<Leader>gr",  ":Gremove<CR>")
-- <Leader>go and <Leader>gy handled by gitlinker.nvim keys

-- indentLine
vim.g.indentLine_enabled = 1

-- Tag navigation
map("n", "<leader>.", "<cmd>lua require('fzf-lua').tags()<CR>", { silent = true, desc = "Find tag" })
map("n", "<leader>tn", ":tn<CR>")
map("n", "<leader>tp", ":tp<CR>")
map("n", "<leader>ts", ":ts<CR>")

-- EasyMotion (<Plug> mappings require remap = true)
vim.g.EasyMotion_do_mapping = 1
vim.g.EasyMotion_startofline = 0
map({ "n", "v" }, "/", "<Plug>(easymotion-sn)", { remap = true })
map("o",           "/", "<Plug>(easymotion-tn)", { remap = true })
map("n", "<Leader>j", "<Plug>(easymotion-overwin-w)", { remap = true })

-- Tagbar
map("", "<leader>tb", ":TagbarToggle<CR>", { silent = true })

-- vim-javascript
vim.g.javascript_plugin_jsdoc = 1

-- FZF-lua
map("n", "<Leader><CR>", "<cmd>lua require('fzf-lua').buffers()<CR>",              { silent = true, desc = "Buffers" })
map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>",                  { silent = true, desc = "Find files" })
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<CR>",              { silent = true, desc = "Live grep" })
map("n", "<leader>fd", "<cmd>lua require('fzf-lua').live_grep_glob()<CR>",         { silent = true, desc = "Live grep (glob filter)" })
map("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>",                { silent = true, desc = "Buffers" })
map("n", "<leader>fw", "<cmd>lua require('fzf-lua').grep_cword()<CR>",             { silent = true, desc = "Grep word under cursor" })
map("n", "<leader>fr", "<cmd>lua require('fzf-lua').resume()<CR>",                 { silent = true, desc = "Resume last search" })

-- Clever-f
vim.g.clever_f_across_no_line = 1

-- vim-prettier
vim.g["prettier#exec_cmd_path"] = ".prettierrc"
map("n", "<Leader>pr", ":Prettier<CR>")

-- vim-go
vim.g.go_fmt_autosave      = 0
vim.g.go_def_mode          = "godef"
vim.g.go_fmt_fail_silently = 1
vim.g.go_gopls_enabled     = 0

-- Go filetype: coc + vim-go mappings
vim.api.nvim_create_autocmd("FileType", {
  group    = augroup,
  pattern  = "go",
  callback = function()
    local opts = { silent = true, buffer = true }
    map("n", "<leader>ge",  ":<C-u>CocList diagnostics<CR>", opts)
    map("n", "U", function()
      local ft = vim.bo.filetype
      if ft == "vim" or ft == "help" then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
      else
        vim.fn["CocAction"]("doHover")
      end
    end, opts)
    map("n", "<leader>rn",  "<Plug>(coc-rename)", { buffer = true, remap = true })
    map("n", "<leader>gob", ":GoBuild<CR>",  opts)
    map("n", "<leader>gf",  ":GoFmt<CR>",    opts)
    map("n", "<leader>gi",  ":GoImports<CR>", opts)
  end,
})

-- CopilotChat
map("n", "<leader>ct", ":CopilotChatToggle<CR>")

-- ===================== VIMSCRIPT FUNCTIONS =====================
-- (kept in VimScript for <SID> scoping and legacy FZF helpers)
vim.cmd([[
  function! Update_ruby_tags()
    return system('ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)')
  endfunction

  function! Update_python_tags()
    return system('ctags -R --fields=+l --languages=python')
  endfunction

  command! CloseHiddenBuffers call s:CloseHiddenBuffers()
  function! s:CloseHiddenBuffers()
    let open_buffers = []
    for i in range(tabpagenr('$'))
      call extend(open_buffers, tabpagebuflist(i + 1))
    endfor
    for num in range(1, bufnr("$") + 1)
      if buflisted(num) && index(open_buffers, num) == -1
        exec "bdelete " . num
      endif
    endfor
  endfunction
]])

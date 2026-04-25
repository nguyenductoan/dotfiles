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
          highlight_git = true,
          root_folder_label = function(path)
            return vim.fn.fnamemodify(path, ":t")
          end,
          icons = {
            show = { git = true },
            glyphs = {
              folder = {
                arrow_open   = "▼",
                arrow_closed = "▷",
              },
              git = {
                unstaged  = "✎",  -- modified
                staged    = "✔",  -- staged
                unmerged  = "⊕",  -- conflict
                renamed   = "➜",  -- renamed
                untracked = "✚",  -- new file
                deleted   = "✖",  -- deleted
                ignored   = "◌",  -- ignored
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
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler  = { line = "gcc", block = "gbc" },
      opleader = { line = "gc",  block = "gb"  },
    },
    keys = {
      { "gc",  desc = "Comment line(s)" },
      { "gb",  desc = "Comment block(s)" },
      { "gcc", desc = "Toggle line comment" },
      { "gbc", desc = "Toggle block comment" },
    },
  },

  -- Git
  "tpope/vim-fugitive",
  {
    "linrongbin16/gitlinker.nvim",
    cmd  = "GitLink",
    keys = {
      { "<Leader>go",  "<cmd>GitLink!<CR>",       mode = { "n", "v" }, desc = "Open in browser" },
      { "<Leader>gy",  "<cmd>GitLink<CR>",        mode = { "n", "v" }, desc = "Copy git link" },
      { "<Leader>gB",  "<cmd>GitLink! blame<CR>", mode = { "n", "v" }, desc = "Open blame on GitHub" },
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
              return routers.github_blame(lk)
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
          local ok, ibl = pcall(require, "ibl")
          if ok then ibl.setup_buffer(bufnr, { enabled = false }) end
        end,
      },
    },
    keys = {
      { "<leader>gd", function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype:match("^Diffview") then
              vim.cmd("DiffviewClose")
              return
            end
          end
          vim.cmd("DiffviewOpen")
        end, desc = "Toggle diff view" },
      { "<leader>gh", function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype:match("^Diffview") then
              vim.cmd("DiffviewClose")
              return
            end
          end
          local ft = vim.bo.filetype
          if ft:match("^Diffview") then
            vim.cmd("DiffviewFileHistory")
          else
            vim.cmd("DiffviewFileHistory %")
          end
        end, desc = "Toggle file history" },
      { "<leader>gH", function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype:match("^Diffview") then
              vim.cmd("DiffviewClose")
              return
            end
          end
          vim.cmd("DiffviewFileHistory")
        end, desc = "Toggle repo history" },
    },
  },

  -- Ruby
  { "tpope/vim-bundler", ft = { "ruby", "eruby", "gemspec" } },
  { "tpope/vim-endwise", ft = { "ruby", "eruby", "lua", "vim" } },


  -- Editing helpers
  "tpope/vim-surround",
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  "easymotion/vim-easymotion",
  "rhysd/clever-f.vim",
  "ntpeters/vim-better-whitespace",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char      = "│",
        tab_char  = "│",
        highlight = "IblIndent",
      },
      scope = { enabled   = false },
    },
  },

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

  -- Treesitter (requires: brew install tree-sitter-cli)
  -- Highlighting enabled via FileType autocmd (vim.treesitter built-in).
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").install({
        "go", "ruby", "javascript", "typescript",
        "lua", "terraform", "hcl", "vim", "vimdoc",
        "bash", "json", "yaml", "helm",
      })
    end,
  },

  -- Languages / Syntax
  "pangloss/vim-javascript",
  "kchmck/vim-coffee-script",
  "hashivim/vim-terraform",
  { "fatih/vim-go", build = ":GoInstallBinaries", ft = "go" },
  { "towolf/vim-helm", ft = "helm" },

  -- LSP / COC
  -- Note: install coc-highlight extension via :CocInstall coc-highlight
  { "neoclide/coc.nvim", branch = "release" },

  -- Navigation
  "christoomey/vim-tmux-navigator",

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
  "ayu-theme/ayu-vim",
  "talha-akram/noctis.nvim",
})

require("lsp")

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
  colorscheme custom-theme

  hi DiffAdd    ctermfg=231 ctermbg=22  cterm=NONE guifg=NONE   guibg=#1e3a2a
  hi DiffChange ctermfg=231 ctermbg=0   cterm=NONE guifg=NONE   guibg=#1a2a3a
  hi DiffDelete ctermfg=196 ctermbg=88  cterm=NONE guifg=#ff5555 guibg=#3a1a1a
  hi DiffText   ctermfg=16  ctermbg=214 cterm=NONE guifg=NONE   guibg=#4a3800
  hi Folded ctermbg=230 ctermfg=166

  highlight NonText guifg=#4a4a59
  highlight SpecialKey guifg=#4a4a59

  hi IblIndent guifg=#3a3a4a gui=nocombine

  hi link NvimTreeNormal        Normal
  hi link NvimTreeEndOfBuffer   NonText
  hi link NvimTreeCursorLine    CursorLine
  hi link NvimTreeFolderName    Directory
  hi link NvimTreeOpenedFolderName Directory
  hi NvimTreeRootFolder guifg=#e0af68 gui=bold

  hi NvimTreeGitNew     guifg=#43D24D  " untracked  ✚ bright green
  hi NvimTreeGitStaged  guifg=#3ACB5E  " staged     ✔ green
  hi NvimTreeGitDirty   guifg=#FCA02F  " modified   ✎ orange
  hi NvimTreeGitRenamed guifg=#1FE0DD  " renamed    ➜ cyan
  hi NvimTreeGitMerge   guifg=#D23C28  " conflict   ⊕ red
  hi NvimTreeGitDeleted guifg=#D15123  " deleted    ✖ red-orange
  hi NvimTreeGitIgnored guifg=#434B53  " ignored    ◌ gray

]])

-- Enable treesitter highlighting via Neovim built-in (new nvim-treesitter rewrite)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

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

-- Write claudecode.nvim WebSocket port to a directory-keyed file so the
-- `cc` shell function can connect the right Claude Code session to this Neovim.
-- File name: nvim_<cwd-basename>_<counter>.port
-- Counter = max existing counter for this directory + 1 (starts at 1).
local port_file_path = nil

local function make_port_path()
  local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local ide_dir  = vim.fn.expand("~/.claude/ide/")
  local matches  = vim.fn.glob(ide_dir .. "nvim_" .. dir_name .. "_*.port", false, true)
  local max_n    = 0
  for _, f in ipairs(matches) do
    local n = f:match("_(%d+)%.port$")
    if n then max_n = math.max(max_n, tonumber(n)) end
  end
  return ide_dir .. "nvim_" .. dir_name .. "_" .. (max_n + 1) .. ".port"
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = function()
    vim.defer_fn(function()
      local ok, server = pcall(require, "claudecode.server.init")
      if ok and server.state and server.state.port then
        port_file_path = make_port_path()
        local f = io.open(port_file_path, "w")
        if f then f:write(tostring(server.state.port)); f:close() end
      end
    end, 1000)
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = augroup,
  callback = function()
    if port_file_path then os.remove(port_file_path) end
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

-- Paste from system clipboard in command-line mode (easymotion search, :commands, etc.)
map("c", "<C-v>", "<C-r>+", { desc = "Paste from clipboard in cmdline" })

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
vim.cmd("EMCommandLineNoreMap <C-v> <C-r>+")

-- vim-javascript
vim.g.javascript_plugin_jsdoc = 1

-- FZF-lua
map("n", "<Leader><CR>", "<cmd>lua require('fzf-lua').buffers()<CR>",              { silent = true, desc = "Buffers" })
-- <leader>ff  — find files; filter inside fzf prompt:
--   user_model          fuzzy match
--   user_model .rb      only paths containing ".rb"
--   app/models .rb      under app/models, .rb only
map("n", "<leader>ff", function()
  require("fzf-lua").files({ fd_opts = "--color=never --type f --hidden --follow --exclude .git" })
end, { silent = true, desc = "Find files" })
-- <leader>fg  — live grep; append " -- <glob>" to filter by filetype:
--   has_many                   all files
--   has_many -- *.rb           Ruby files only
--   render -- *.{rb,erb}       Ruby + ERB
--   import -- src/**/*.ts      TypeScript under src/
map("n", "<leader>fg", function()
  require("fzf-lua").live_grep({
    glob_flag      = "--iglob",  -- rg flag used before the glob pattern
    glob_separator = "%s%-%-",   -- separator between pattern and glob
  })
end, { silent = true, desc = "Live grep" })
map("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>",                { silent = true, desc = "Buffers" })
-- <leader>fw  — grep word/selection; fzf opens pre-filled, append " -- <glob>" to filter:
--   (cursor on has_many)  <leader>fw           grep "has_many" everywhere
--   (cursor on has_many)  <leader>fw  then add -- *.rb  to narrow to Ruby files
map("n", "<leader>fw", function()
  require("fzf-lua").grep_cword({ glob_flag = "--iglob", glob_separator = "%s%-%-" })
end, { silent = true, desc = "Grep word under cursor" })
map("v", "<leader>fw", function()
  require("fzf-lua").grep_visual({ glob_flag = "--iglob", glob_separator = "%s%-%-" })
end, { silent = true, desc = "Grep selection" })
map("n", "<leader>fr", "<cmd>lua require('fzf-lua').resume()<CR>",                 { silent = true, desc = "Resume last search" })

-- Clever-f
vim.g.clever_f_across_no_line = 1

-- vim-go
vim.g.go_fmt_autosave      = 0
vim.g.go_fmt_fail_silently = 1
vim.g.go_gopls_enabled     = 0   -- coc.nvim owns gopls; don't let vim-go start a second one
vim.g.go_def_mapping_enabled = 0  -- disable vim-go's gd; we map it to coc below
-- Let treesitter own Go syntax; disable vim-go's regex highlights
vim.g.go_highlight_types            = 0
vim.g.go_highlight_fields           = 0
vim.g.go_highlight_functions        = 0
vim.g.go_highlight_function_calls   = 0
vim.g.go_highlight_operators        = 0
vim.g.go_highlight_extra_types      = 0

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

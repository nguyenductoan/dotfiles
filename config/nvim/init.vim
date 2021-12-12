" ===================== Bundle Scripts ======================

if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
  set runtimepath+=~/.config/nvim/
endif

let neobundle_readme=expand('~/.config/nvim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.config/nvim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"
endif

let g:ackprg = 'ag --nogroup --nocolor --column'
"---------------------------------------
call neobundle#begin(expand('$HOME/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'tpope/vim-rhubarb'                             " Enables :Gbrowse from fugitive.vim to open GitHub URLs.
"NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'                          " look like it will cause performance issue
NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'ntpeters/vim-better-whitespace'
"NeoBundle 'slim-template/vim-slim.git'
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'christoomey/vim-tmux-navigator'                "  navigate seamlessly between vim and tmux splits
NeoBundle 'majutsushi/tagbar'
"NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'Glench/Vim-Jinja2-Syntax'
NeoBundle 'mattn/emmet-vim'                               " high speed coding for html and css
"NeoBundle 'wesQ3/vim-windowswap'                          " use to swap window
NeoBundle 'ngmy/vim-rubocop'
NeoBundle 'prettier/vim-prettier'
"NeoBundle 'w0rp/ale'
"NeoBundle 'eugen0329/vim-esearch'                         " search and replace like Sublime/Atom
NeoBundle 'mklabs/split-term.vim'
NeoBundle 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" using gocode from: https://github.com/mdempsky/gocode
NeoBundle 'deoplete-plugins/deoplete-go', {'build': {'unix': 'make'}}
NeoBundle 'neomake/neomake'
" https://medium.com/@rohmanhakim/how-to-set-up-code-completion-for-vim-in-macos-9766dd459385
NeoBundle 'neoclide/coc.nvim', 'release', { 'build': { 'others': 'git checkout release' } }
NeoBundle 'neoclide/coc-highlight'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'tomlion/vim-solidity'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" ===================== End NeoBundle Scripts =====================

" --------------------------------------------------------
" VIM SETTING
" --------------------------------------------------------

set expandtab
set tabstop=2                                               " number of spaces that a <Tab> in the file counts for
set shiftwidth=2                                            " number of spaces to use for each step of (auto)indent
set softtabstop=2                                           " spaces feel like tabs
set smartindent                                             " auto tabs when going to next line
set modeline
set hlsearch                                                " Highlight search results
set incsearch
set autoindent                                              " always set auto-indenting on
set copyindent                                              " copy the previous indentation on auto-indenting
set ruler                                                   " line and column number
set number
set autoread                                                " automatically read file when it changed
set backspace=indent,eol,start
"set cursorline                                             " highlight current cursor line(performance issue)
"set cursorcolumn
set scrolloff=5                                             " lines of text around cursor
set wrap                                                    " turn on line wrapping
"set foldmethod=manual                                      " manual folding selected text
set foldmethod=indent
set foldlevelstart=20
set wildmenu                                                " Turn on the WiLd menu
set wildmode=longest:list,full
set fillchars+=vert:\|                                       " Delete pipe characters on styling vertical split borders
                                                            "(note the significant whitespace after the '\' character)
set timeoutlen=500 ttimeoutlen=0                           " timeoutlen is used for mapping delays, and ttimeoutlen is used for key code delays
set clipboard=unnamedplus


hi VertSplit guibg=NONE cterm=NONE                          " Transparent background for split borders
hi CursorLine term=bold cterm=bold guibg=Grey40             " highlight line cursor
highlight ColorColumn cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40
hi SignColumn ctermbg=NONE                                  " set color for SignColumn (the column next to column of line number)

au BufRead,BufNewFile *.hamlc set ft=haml                   " hamlc syntax highlighting

" Change color search and visual mode
highlight Visual cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40
highlight Search cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40

" set color for vim diff: https://github.com/kshenoy/vim-sol/blob/master/colors/sol-term.vim
hi DiffAdd       ctermfg=231  ctermbg=22   cterm=NONE
hi DiffChange    ctermfg=231  ctermbg=0   cterm=NONE
hi DiffDelete    ctermfg=196  ctermbg=88   cterm=NONE
hi DiffText      ctermfg=16   ctermbg=214  cterm=NONE
hi Folded ctermbg=230 ctermfg=166 " Corlor of folding

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

syntax on
syntax enable

" Display filename in vim:
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

" toggle invisible characters
set list lcs=tab:\.\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

" Make vim use the system clipboard:
set clipboard^=unnamed,unnamedplus

set splitright "split new window on the right of the current window
set splitbelow  " split new win below the current window
set bg=light    " from neovim version 0.3.2 the default background is 'dark'

syntime on " user with ':syntime report' to tract performance
"set ttyfast " use for slow terminal
"set lazyredraw " buffer screen updates instead of updating all the time


" check one time after 4s of inactivity in normal mode (auto update file
" change)
au CursorHold * checktime

"autoread when switch buffer or forcus on vim again
au FocusGained,BufEnter * :silent! !

" disable beep sound
set noeb vb t_vb=

set re=1
" --------------------------------------------------------
" VIM MAPPING
" --------------------------------------------------------

"map <leader>t :terminal<CR>

" remap leader
let mapleader = "\<Space>"

" remap esc
inoremap jk <esc>

" toggle cursor line
"nnoremap <leader>lc :set cursorline!<cr>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" remap Tabs key
"nnoremap <Tab> gt
"nnoremap <S-Tab> gT

" open new tab
nnoremap <silent> <C-t> :tabnew<CR>

" move between window
"nmap <C-j> <C-w>j
"nmap <C-k> <C-w>k
"nmap <Leader>o <C-w>l
"if has('nvim')
  "map <BS> <C-W>h
"else
  "map <C-h> <C-w>h
"endif
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

map <Leader>w :w<CR>                                        " Save file
map <Leader>q :q<CR>                                        " Quit file
map <Leader>e :e<CR>                                        " Edit file
"map <Leader>qa :qa<CR>                                      " quit all files (it will cause slow on <Leader>q mapping)
"map <Silent><Leader>va <ESC>ggVG<CR>                        " Select all file
map <C-s> <ESC>gg<S-v>G
" C-q : visual block

" copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" resize pane
nmap + :vertical resize +5<cr>
nmap _ :vertical resize -5<cr>

" ZoomFullPanel
"nmap Z <C-w>\|
" UnZoom
"nmap z <C-w>=

" map folding
nnoremap <Leader>f za

" paste multiple times
xnoremap p pgvy

" map indentation key to tab
"nnoremap <TAB> >>
"nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" vertical split current buffer
nnoremap <Leader>i :vsplit<CR>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Move to beginning/end of line
nnoremap B ^
nnoremap E $

" Exit terminal
:tnoremap jk <C-\><C-n>

" copy current relative path (src/foo.txt) to system clipboard
nnoremap <silent> yp :let @+=expand("%")<CR>

" copy current absolute path (/something/src/foo.txt) to system clipboard
nnoremap <silent> yP :let @+=expand("%:p")<CR>

" filename       (foo.txt)
nnoremap <silent> yf :let @+=expand("%:t")<CR>

" directory name (/something/src)
nnoremap <silent>yd :let @+=expand("%:p:h")<CR>

map <silent> <leader>urt <ESC>:call Update_ruby_tags()<CR>
map <silent> <leader>upt <ESC>:call Update_python_tags()<CR>
map <C-c> "+y<CR>


" --------------------------------------------------------
" Vim Airline
" --------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let airline#extensions#default#section_use_groupitems = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tagbar#enabled = 0
let g:airline_section_z = '%l/%L : %c'


" --------------------------------------------------------
" The Silver Searcher
" --------------------------------------------------------

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
"nnoremap K :grep! '\b<C-R><C-W>\b'<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!


" --------------------------------------------------------
" Deoplete
" --------------------------------------------------------

let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" --------------------------------------------------------
"" Fugitive
" --------------------------------------------------------

noremap <Leader>ga :Gwrite<CR>

" Make the default commit binding be verbose
noremap <Leader>gc :Gcommit -v<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>
noremap <Leader>gw :GBrowse<CR>


" --------------------------------------------------------
" indextLine
" --------------------------------------------------------

let g:indentLine_enabled = 1


" --------------------------------------------------------
" CtrlP
" --------------------------------------------------------

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_custom_ignore = {
  "\ 'dir':  '\v[\/]\.(git|hg|svn)$',
  "\ 'file': '\v\.(exe|so|dll)$',
  "\ 'link': 'some_bad_symbolic_links',
  "\ }

let g:ctrlp_working_path_mode = 'r'

"let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1


" --------------------------------------------------------
" Ctags
" --------------------------------------------------------

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>tn :tn<cr>                                 " Move to next tag
nnoremap <leader>tp :tp<cr>                                 " Move to previous tag
nnoremap <leader>ts :ts<cr>                                 " List all tags


" --------------------------------------------------------
" EASYMOTION
" --------------------------------------------------------

let g:EasyMotion_do_mapping = 1                             " Disable default mappings
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"nmap <silent> <tab> <Plug>(easymotion-w)
"map <Leader>l <Plug>(easymotion-lineforward)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"map <Leader>h <Plug>(easymotion-linebackward)
nmap <Leader>j <Plug>(easymotion-overwin-w)

let g:EasyMotion_startofline = 0                            " keep cursor column when JK motion


map <silent> <leader>tb <ESC>:TagbarToggle<CR>


" --------------------------------------------------------
" NERDTRee
" --------------------------------------------------------

map <silent> <leader>ls <ESC>:NERDTreeToggle<CR>
nmap <silent> <leader>y :NERDTreeFind<cr>                   " expand to the path of the file in the current buffer

let NERDTreeShowHidden=0
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'
"let NERDTreeMapOpenInTab='<ENTER>'


" --------------------------------------------------------
" vim-javascript
" --------------------------------------------------------
"
let g:javascript_plugin_jsdoc = 1


" --------------------------------------------------------
" vim-rails
" --------------------------------------------------------
map <Leader>c :Vcontroller<SPACE>
map <Leader>vc :Vcontroller<CR>
map <Leader>ec :Econtroller<CR>

"map <Leader>vh :Vhelper<SPACE>
"map <Leader>vf :Vfactory<SPACE>

map <Leader>m :Vmodel<SPACE>
map <Leader>em :Emodel<SPACE>

map <Leader>vv :Vview<SPACE>
map <Leader>ev :Eview<CR>
map <Leader>rv :RV<CR>


" --------------------------------------------------------
" MAPPING FZF
" --------------------------------------------------------

let g:fzf_buffers_jump = 1
"map <silent> <leader>aa <ESC>:call fzf#vim#ag(expand("<cword>"), fzf#vim#layout(expand("<bang>0")))<cr>
"map <c-f> <ESC>:call fzf#vim#tags(expand("<cword>"), fzf#vim#layout(expand("<bang>0")))<cr>

map <leader>a <ESC>:call SearchByKeyWordInAllFolders()<CR>
map <leader>s <ESC>:call SearchByFileName()<CR>
map <leader>d <ESC>:call SearchInSpecificFolder()<CR>

let g:fzf_file_name_only=" -d '/' --nth=-1"
let g:fzf_preview_source=" --preview 'pygmentize -g {} 2>/dev/null \|\| head -200 {}'"
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

map <leader>bb :Buffers<CR>

" --------------------------------------------------------
" clever-f
" --------------------------------------------------------

let g:clever_f_across_no_line = 1


" --------------------------------------------------------
" vim-windowswap
" --------------------------------------------------------
nnoremap <silent> <leader>mm :call WindowSwap#EasyWindowSwap()<CR>


" --------------------------------------------------------
" vim-rubocop
" --------------------------------------------------------
let g:vimrubocop_config = '.rubocop.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>


" --------------------------------------------------------
" vim-prettier
" --------------------------------------------------------
let g:prettier#exec_cmd_path = '.prettierrc'
nmap <Leader>pr :Prettier<CR>


" --------------------------------------------------------
" ALE
" --------------------------------------------------------
"let g:ale_linters = {
"\   'go': ['bingo', 'gotype', 'golint', 'golangci-lint'],
"\}

"let g:ale_fixers = {
"\   'go': ['goimports', 'gofmt'],
"\}

"let g:ale_fix_on_save = 1

"let g:airline#extensions#ale#enabled = 1
"let g:ale_echo_msg_error_str = 'E'
"let g:ale_echo_msg_warning_str = 'W'
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_set_highlights = 0
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1

" --------------------------------------------------------
" coc
" --------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" Show all diagnostics
autocmd FileType go nnoremap <silent> <leader>ge  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
"autocmd FileType go nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
" Use U to show documentation in preview window
autocmd FileType go nnoremap <silent> U :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Remap for rename current word
autocmd FileType go nmap <leader>rn <Plug>(coc-rename)

" Better display for messages
set cmdheight=1

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns (the column next to the line number column)
set signcolumn=yes

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" --------------------------------------------------------
" neomake
" --------------------------------------------------------

" enable neomake for linting
"au FileType go autocmd BufWritePost * Neomake
"let g:go_metalinter_command='golangci-lint'
""let g:go_metalinter_autosave = 1
"let g:go_metalinter_enabeld = ['deadcode', 'errcheck', 'gosimple', 'govet', 'golint', 'staticcheck', 'typecheck', 'unused', 'varcheck']
"let g:go_list_type = 'quickfix'

"let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
"let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeErrorSign'}
"let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
"let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}
""let g:neomake_go_enabled_makers = [ 'golint', 'govet', 'go' ]
"let g:neomake_go_enabled_makers = [ 'go', 'gometalinter' ]
"let g:neomake_logfile = '/tmp/neomake.log'
""let g:neomake_open_list = 2 " auto open error list
"let g:neomake_go_gometalinter_maker = {
	"\ 'args': [
	"\   '--tests',
	"\   '--enable-gc',
	"\   '--concurrency=3',
	"\   '--fast',
	"\   '-D', 'aligncheck',
	"\   '-D', 'dupl',
	"\   '-D', 'gocyclo',
	"\   '-D', 'gotype',
	"\   '-E', 'errcheck',
	"\   '-E', 'misspell',
	"\   '-E', 'unused',
	"\   '%:p:h',
	"\ ],
	"\ 'append_file': 0,
	"\ 'errorformat':
	"\   '%E%f:%l:%c:%trror: %m,' .
	"\   '%W%f:%l:%c:%tarning: %m,' .
	"\   '%E%f:%l::%trror: %m,' .
	"\   '%W%f:%l::%tarning: %m'
"\ }

"nnoremap <leader>no :lopen<cr>
"nnoremap <leader>nc :lclose<cr>

" --------------------------------------------------------
" vim-go
" --------------------------------------------------------
"let g:go_highlight_build_constraints = 1
"let g:go_highlight_extra_types = 1
"let g:go_highlight_fields = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_operators = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_types = 1
let g:go_fmt_autosave = 0
let g:go_def_mode='godef'             " 'godef' will be faster than 'guru' (the default tool for jumping)
let g:go_fmt_fail_silently = 1
let g:go_gopls_enabled = 0
" Show type information
"let g:go_auto_type_info = 1

nnoremap <leader>gob :GoBuild<cr>
autocmd FileType go nnoremap <leader>gf :GoFmt<cr>
autocmd FileType go nnoremap <leader>gi :GoImports<cr>

" --------------------------------------------------------
" vim-esearch
" --------------------------------------------------------


" Super charged File finder
" --------------------------------------------------------
" FUNCTIONS
" --------------------------------------------------------

" Update ruby ctags
function! Update_ruby_tags()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)')
endfunction

" Update python ctags
function! Update_python_tags()
  return system('ctags -R --fields=+l --languages=python')
)')
endfunction

function! SearchByFileName()
  call fzf#vim#files('.', {'options': g:fzf_preview_source })
endfunction

function! SearchByKeyWordInAllFolders()
  call inputsave()
  let keyword = input('Enter keyword to search: ')
  "let dir = input('Enter keywod to search: ')
  call inputrestore()
  "call fzf#vim#ag(dir, "", fzf#vim#layout(expand("<bang>0")))
  call fzf#vim#ag(keyword, { 'options': g:fzf_preview_source })
endfunction

function! SearchInSpecificFolder()
  let dir = input('Enter folder to search: ')
  call inputrestore()
  call inputsave()
  let keyword = input('Enter keyword to search: ')
  call inputrestore()
  let current_dir = getcwd()                              " get current directory
  call fzf#vim#ag(keyword, { 'dir': current_dir . '/app/' . dir, 'down': '40%'})
endfunction

" Close all hidden buffers
" https://gist.github.com/skanev/1068214
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction

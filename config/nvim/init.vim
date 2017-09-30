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
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
"NeoBundle 'Yggdroot/indentLine'                          " look like it will cause performance issue
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'slim-template/vim-slim.git'
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'jiangmiao/auto-pairs'
"NeoBundle 'ivalkeen/vim-ctrlp-tjump'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'christoomey/vim-tmux-navigator'                "  navigate seamlessly between vim and tmux splits
NeoBundle 'majutsushi/tagbar'
NeoBundle 'phongnh/vim-copypath'                          " copypath file name, file path
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'rhysd/clever-f.vim'

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
set scrolloff=3                                             " lines of text around cursor
set wrap                                                    " turn on line wrapping
"set foldmethod=manual                                      " manual folding selected text
set foldmethod=indent
set foldlevelstart=20

hi CursorLine term=bold cterm=bold guibg=Grey40<Paste>      " highlight line cursor

au BufRead,BufNewFile *.hamlc set ft=haml                   " hamlc syntax highlighting

" Change color search and visual mode
highlight Visual cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40
highlight Search cterm=NONE ctermbg=0 ctermfg=NONE guibg=Grey40

" set color for vim diff: https://github.com/kshenoy/vim-sol/blob/master/colors/sol-term.vim
hi DiffAdd       ctermfg=231  ctermbg=22   cterm=NONE
hi DiffChange    ctermfg=231  ctermbg=0   cterm=NONE
hi DiffDelete    ctermfg=196  ctermbg=88   cterm=NONE
hi DiffText      ctermfg=16   ctermbg=214  cterm=NONE

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

syntax on
syntax enable

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set clipboard=unnamed
set splitright

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

" remap leader
let mapleader = "\<Space>"

" remap esc
inoremap jk <esc>

" toggle cursor line
nnoremap <leader>i :set cursorline!<cr>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" remap Tabs key
"nnoremap <Tab> gt
"nnoremap <S-Tab> gT

" open new tab
nnoremap <silent> <S-t> :tabnew<CR>

" move between window
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
if has('nvim')
  map <BS> <C-W>h
else
  map <C-h> <C-w>h
endif

map <Leader>w :w<CR>                                        " Save file
map <Leader>q :q<CR>                                        " Quit file
map <Leader>e :e<CR>                                        " Edit file
"map <Leader>qa :qa<CR>                                      " quit all files (it will cause slow on <Leader>q mapping)
map <Silent><Leader>va <ESC>ggVG<CR>                        " Select all file
map <C-a> <ESC>gg<S-v>G

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
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

"nnoremap <Leader>f :Ag<SPACE>


" --------------------------------------------------------
" vim-ctrlp-tjump
" --------------------------------------------------------

"nnoremap <c-]> :CtrlPtjump<cr>
"vnoremap <c-]> :CtrlPtjumpVisual<cr>


" --------------------------------------------------------
" Deoplete
" --------------------------------------------------------

let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" --------------------------------------------------------
"" Fugitive
" --------------------------------------------------------

noremap <Leader>ga :Gwrite<CR>

" Make the default commit binding be verbose
noremap <Leader>gc :Gcommit -v<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>




" --------------------------------------------------------
" indextLine
" --------------------------------------------------------

"let g:indentLine_enabled = 1


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


" --------------------------------------------------------
" EASYMOTION
" --------------------------------------------------------

let g:EasyMotion_do_mapping = 1                             " Disable default mappings
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"nmap <silent> <tab> <Plug>(easymotion-w)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

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
" vim-copypath
" --------------------------------------------------------
nnoremap <silent> yp :CopyRelativePath<CR>
nnoremap <silent> yP :CopyRelativePath!<CR>
nnoremap <silent> yu :CopyFullPath<CR>
nnoremap <silent> yU :CopyFullPath!<CR>
nnoremap <silent> yd :CopyParentPath<CR>
nnoremap <silent> yD :CopyParentPath!<CR>


" --------------------------------------------------------
" MAPPING MISC
" --------------------------------------------------------

map <silent> <leader>urt <ESC>:call Update_ruby_tags()<CR>
map <C-c> "+y<CR>


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


" Super charged File finder
" --------------------------------------------------------
" FUNCTIONS
" --------------------------------------------------------

" Update ruby ctags
function! Update_ruby_tags()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)')
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



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
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'slim-template/vim-slim.git'
NeoBundle 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'jiangmiao/auto-pairs'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" ===================== End NeoBundle Scripts =====================


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
set cursorline
set scrolloff=3                                             " lines of text around cursor
set wrap                                                    " turn on line wrapping

hi CursorLine term=bold cterm=bold guibg=Grey40<Paste>      " highlight line cursor

au BufRead,BufNewFile *.hamlc set ft=haml                   " hamlc syntax highlighting

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

syntax on
syntax enable

" toggle invisible characters
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪


" --------------------------------------------------------
" The Silver Searcher
" --------------------------------------------------------

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap <Leader>f :Ag<SPACE>


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


" --------------------------------------------------------
" NERDTRee
" --------------------------------------------------------

map <silent> <leader>ls <ESC>:NERDTreeToggle<CR>
nmap <silent> <leader>y :NERDTreeFind<cr>                   " expand to the path of the file in the current buffer

let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '▷'
let NERDTreeDirArrowCollapsible = '▼'


" --------------------------------------------------------
" MAPPING MISC
" --------------------------------------------------------

map <silent> <leader>urt <ESC>:call URT()<CR>
map <C-c> "+y<CR>


" --------------------------------------------------------
" MAPPING FZF
" --------------------------------------------------------

map <silent> <leader>aa <ESC>:call fzf#vim#ag(expand("<cword>"), fzf#vim#layout(expand("<bang>0")))<cr>
map <leader>as <ESC>:call AgInFolder()<CR>
map <c-]> <ESC>:call fzf#vim#tags(expand("<cword>"), fzf#vim#layout(expand("<bang>0")))<cr>
map <leader>s :Files<CR>


" --------------------------------------------------------
" FUNCTIONS
" --------------------------------------------------------

" Update ruby ctags
function! URT()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)')
endfunction
function! AgInFolder()
  call inputsave()
  let dir = input('Enter folder to search in: ')
  call inputrestore()
  call fzf#vim#ag(dir, "", fzf#vim#layout(expand("<bang>0")))
endfunction


" --------------------------------------------------------
" VIM MAPPING
" --------------------------------------------------------

" remap esc
inoremap jk <esc>

" toggle cursor line
nnoremap <leader>i :set cursorline!<cr>

" scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" remap Tabs key
nnoremap <Tab> gt
nnoremap <S-Tab> gT

" open new tab
nnoremap <silent> <S-t> :tabnew<CR>


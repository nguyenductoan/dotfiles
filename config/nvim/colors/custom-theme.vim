" Colorscheme generated from iTerm2 profile: nguyenductoan
" Source: ~/works/personal/dotfiles/nguyenductoan.json

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "nguyenductoan"

" iTerm ANSI palette (converted from Calibrated RGB floats to hex)
" bg:      #09141B   fg:      #E8D3BB
" ansi 0:  #18384D   ansi 1:  #D15123
" ansi 2:  #027C9B   ansi 3:  #FCA02F
" ansi 4:  #358794   ansi 5:  #2A8F39
" ansi 6:  #50A3B5   ansi 7:  #DEB88D
" ansi 8:  #434B53   ansi 9:  #D23C28
" ansi 10: #43D24D   ansi 11: #FDD39F
" ansi 12: #1FE0DD   ansi 13: #6BB8D0
" ansi 14: #3ACB5E   ansi 15: #FFE4CE

" Syntax
hi Normal         guifg=#E8D3BB  guibg=#09141B  ctermfg=7   ctermbg=0
hi Comment        guifg=#358794  guibg=NONE     ctermfg=4   ctermbg=NONE  gui=italic cterm=italic
hi Constant       guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi String         guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi Character      guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi Number         guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi Boolean        guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi Float          guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi Identifier     guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE  gui=NONE cterm=NONE
hi Function       guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Statement      guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE  gui=NONE cterm=NONE
hi Keyword        guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Conditional    guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Repeat         guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Label          guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Operator       guifg=#DEB88D  guibg=NONE     ctermfg=7   ctermbg=NONE
hi Exception      guifg=#D23C28  guibg=NONE     ctermfg=9   ctermbg=NONE
hi PreProc        guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi Include        guifg=#3ACB5E  guibg=NONE     ctermfg=14  ctermbg=NONE
hi Define         guifg=#3ACB5E  guibg=NONE     ctermfg=14  ctermbg=NONE
hi Macro          guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi Type           guifg=#6BB8D0  guibg=NONE     ctermfg=13  ctermbg=NONE
hi StorageClass   guifg=#6BB8D0  guibg=NONE     ctermfg=13  ctermbg=NONE
hi Structure      guifg=#6BB8D0  guibg=NONE     ctermfg=13  ctermbg=NONE
hi Typedef        guifg=#6BB8D0  guibg=NONE     ctermfg=13  ctermbg=NONE
hi Special        guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi SpecialChar    guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Tag            guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Delimiter      guifg=#DEB88D  guibg=NONE     ctermfg=7   ctermbg=NONE
hi SpecialComment guifg=#6BB8D0  guibg=NONE     ctermfg=13  ctermbg=NONE  gui=italic cterm=italic
hi Error          guifg=#D23C28  guibg=NONE     ctermfg=9   ctermbg=NONE  gui=bold cterm=bold
hi Todo           guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE  gui=bold cterm=bold
hi Underlined     guifg=NONE     guibg=NONE     gui=underline cterm=underline

" UI
hi LineNr         guifg=#358794  guibg=NONE     ctermfg=4   ctermbg=NONE
hi CursorLineNr   guifg=#FDD39F  guibg=NONE     ctermfg=11  ctermbg=NONE
hi CursorLine     guifg=NONE     guibg=#18384D  ctermfg=NONE ctermbg=0   gui=NONE cterm=NONE
hi ColorColumn    guifg=NONE     guibg=#18384D  ctermfg=NONE ctermbg=0
hi SignColumn     guifg=#358794  guibg=NONE     ctermfg=4   ctermbg=NONE
hi VertSplit      guifg=#18384D  guibg=NONE     ctermfg=0   ctermbg=NONE  gui=NONE cterm=NONE
hi Folded         guifg=#50A3B5  guibg=#18384D  ctermfg=6   ctermbg=0
hi FoldColumn     guifg=#50A3B5  guibg=NONE     ctermfg=6   ctermbg=NONE
hi Search         guifg=#09141B  guibg=#FDD39F  ctermfg=0   ctermbg=11
hi IncSearch      guifg=#09141B  guibg=#1FE0DD  ctermfg=0   ctermbg=12
hi Visual         guifg=NONE     guibg=#18384D  ctermfg=NONE ctermbg=0
hi StatusLine     guifg=#E8D3BB  guibg=#18384D  ctermfg=7   ctermbg=0   gui=NONE cterm=NONE
hi StatusLineNC   guifg=#434B53  guibg=#18384D  ctermfg=8   ctermbg=0   gui=NONE cterm=NONE
hi WildMenu       guifg=#09141B  guibg=#1FE0DD  ctermfg=0   ctermbg=12
hi Pmenu          guifg=#E8D3BB  guibg=#18384D  ctermfg=7   ctermbg=0
hi PmenuSel       guifg=#09141B  guibg=#1FE0DD  ctermfg=0   ctermbg=12
hi PmenuSbar      guifg=NONE     guibg=#18384D  ctermfg=NONE ctermbg=0
hi PmenuThumb     guifg=NONE     guibg=#50A3B5  ctermfg=NONE ctermbg=6
hi TabLine        guifg=#434B53  guibg=#18384D  ctermfg=8   ctermbg=0   gui=NONE cterm=NONE
hi TabLineSel     guifg=#E8D3BB  guibg=#09141B  ctermfg=7   ctermbg=NONE gui=NONE cterm=NONE
hi TabLineFill    guifg=NONE     guibg=#18384D  ctermfg=NONE ctermbg=0   gui=NONE cterm=NONE
hi Title          guifg=#43D24D  guibg=NONE     ctermfg=10  ctermbg=NONE  gui=bold cterm=bold
hi NonText        guifg=#18384D  guibg=NONE     ctermfg=0   ctermbg=NONE
hi SpecialKey     guifg=#18384D  guibg=NONE     ctermfg=0   ctermbg=NONE
hi MatchParen     guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE  gui=bold,underline cterm=bold,underline
hi ErrorMsg       guifg=#D23C28  guibg=NONE     ctermfg=9   ctermbg=NONE
hi WarningMsg     guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi ModeMsg        guifg=#43D24D  guibg=NONE     ctermfg=10  ctermbg=NONE
hi MoreMsg        guifg=#43D24D  guibg=NONE     ctermfg=10  ctermbg=NONE
hi Question       guifg=#43D24D  guibg=NONE     ctermfg=10  ctermbg=NONE

" Diff
hi DiffAdd        guifg=#43D24D  guibg=NONE     ctermfg=10  ctermbg=NONE
hi DiffChange     guifg=#FCA02F  guibg=NONE     ctermfg=3   ctermbg=NONE
hi DiffDelete     guifg=#D23C28  guibg=NONE     ctermfg=9   ctermbg=NONE
hi DiffText       guifg=#FDD39F  guibg=NONE     ctermfg=11  ctermbg=NONE  gui=bold cterm=bold

" Git gutter
hi GitGutterAdd    guifg=#43D24D  guibg=NONE    ctermfg=10  ctermbg=NONE
hi GitGutterChange guifg=#FCA02F  guibg=NONE    ctermfg=3   ctermbg=NONE
hi GitGutterDelete guifg=#D23C28  guibg=NONE    ctermfg=9   ctermbg=NONE

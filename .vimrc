"common
set autochdir
set autoindent
set bsdir=buffer
set cc=81
set cindent
set columns=200 lines=50
set cuc
set cursorline
set expandtab
set go=
set guifont=Source_Code_Pro_Light:h15
set hls
set incsearch
set list
set listchars=eol:‹
set nobackup
set number
set ruler
set so=4
set showcmd
set shiftwidth=4
set showmatch
set smartindent
set smarttab
set softtabstop=4
set t_Co=256
set tabstop=4
set transparency=15
syntax on
colo desert2
set background=dark
retab

hi NonText ctermfg=darkgrey guifg=darkgrey 
hi clear SpecialKey 
hi link SpecialKey NonText 
set tags+=~/.vim/tags/cpp

call pathogen#infect()

"tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_width = 35
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_left = 1
autocmd VimEnter * nested :call tagbar#autoopen(1)

"let g:indentLine_color_gui='#A4E57E'
"let g:indentLine_char = '|'

"solarized
"colo solarized

"cursor move in edit mode
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk

"xpdf
command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -

"syntastic 
execute pathogen#infect()
hi SyntasticErrorSign guifg=white guibg=red
hi SyntasticErrorLine guibg=#2f0000
let g:syntastic_check_on_wq=0
set statusline+=%{SyntasticStatuslineFlag()}
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=0
autocmd VimEnter * nested :SyntasticToggleMode
nmap <silent> <F5> :SyntasticToggleMode<CR>
hi LineNr gui = italic guifg = lightblue3 guibg=grey10

"neocomplcache
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_enable_cursor_hold_i = 1
let g:neocomplcache_enable_insert_char_pre = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_max_list = 20
inoremap <expr><tab> pumvisible() ? neocomplcache#close_popup() . "\<SPACE>" : "\<TAB>"

"vimtones
let g:vimtonesTurnOn = 0
let g:vimtonesPlaySound = 0
let g:vimtonesChangeVol = 1
let g:lastinputTime = str2float(reltimestr(reltime()))

hi Pmenu guibg = darkgray guifg = white
hi PmenuSel guibg = orange
hi MatchParen guibg = red

"dictionary
set dictionary-=~/.vim/dict.txt dictionary+=~/.vim/dict.txt
set complete-=k complete+=k

"code folding
"set fdm=indent

"indent 
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size  = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=gray50   ctermbg=3
hi IndentGuidesEven guibg=darkolivegreen4 ctermbg=4
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=white ctermbg=2
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgray ctermbg=3
":if expand("%") == ""|browse confirm w|else|confirm w|endif

"brackets auto complete
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"inoremap { {}<LEFT><ENTER><ENTER><UP><TAB>
"inoremap // <ESC>::call AppendComment()<CR>a
function! AppendComment()
    let col_number = col(".")
    while col_number < 81
        execute "normal! a "
        let col_number += 1
    endwhile
    execute "normal! a/*  */\<LEFT>\<LEFT>\<LEFT>"
endfunc
"function! ParenClose()
"  let line = getline('.')
"  let char = line[col('.')]
"
"  if char == ')'
"    execute "normal! l"
"  else
"    normal! a)
"  end
"endfunction
"inoremap ) <ESC>:call ParenClose()<CR>a

"powerline
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'fancy'
let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'default'
set encoding=utf-8

"add tags
func AddTags()
    call append(0, "/*")
    call append(1, "*   Copyright (C) Ds ds303077135@Gmail.com")
    call append(2, "*   File Name     : ".expand("%:t"))
    call append(3, strftime("*   Creation Time : %Y/%m/%d %T"))
    call append(4, "*   Environment   : OS X 10.8 & Vim 7.3")
    call append(5, "*/")
    call append(6, "#include <algorithm>")
    call append(7, "#include <iostream>")
    call append(8, "#include <cstdlib>")
    call append(9, "#include <cstring>")
    call append(10, "#include <cstdio>")
    call append(11, "#include <string>")
    call append(12, "#include <vector>")
    call append(13, "#include <cmath>")
    call append(14, "#include <map>")
    call append(15, "#include <set>")
    call append(16, "#define rep(i, n) for(int i = 1; i <= n; ++i)")
    call append(17, "#define sqr(x) ((x) * (x))")
    call append(18, "#define pb push_back")
    call append(19, "#define mp make_pair")
    call append(20, "#define sign(x) (x < 0 ? -1 : (x > 0))")
    call append(21, "#define debug(x) cout << #x << \" = \" << x << endl")
    call append(22, "using namespace std;")
    "call append(23, "");
    call append(24, "int main(){")
    call append(25, "    return 0;")
    call append(26, "}")
endfunc

"add highlighting for function definition in C++
"function! EnhanceCppSyntax()
"  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
"  hi def link cppFuncDef Special
"endfunction
"autocmd Syntax cpp call EnhanceCppSyntax()
"auto correct

"brackets color
let g:rainbowbrackets_colors =
            \ [
            \   'guifg=grey70',
            \   'guifg=grey80',
            \   'guifg=grey90',
            \   'guifg=white'
            \ ]
let g:rainbowbrackets_enable_round_brackets = 1
let g:rainbowbrackets_enable_curly_brackets = 1
let g:rainbowbrackets_enable_square_brackets = 1
let g:rainbowbrackets_enable_angle_brackets = 1
call rainbowbrackets#update()

"highlight current keyword
"autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
let g:HiCursorWords_delay = 200

iab retrun return
iab whiel while
iab inlcude include
iab sawp swap
iab asn ans

"compile
func Compile()
exec "w"
exec "!g++ -g % -o %<"
endfunc

func Run()
exec "w"
exec "!./%<"
endfunc

func Debug()
exec "w"
exec "!gdb ./%<"
endfunc

func ThreadCompile()
exec "w"
exec "!clang++ -std=c++0x -stdlib=libc++ %"
endfunc

map <F8> :call Compile()<CR>
map <F7> :call Run()<CR>
map <F6> :call Debug()<CR>
map <F1> :call AddTags()<CR>
map <F9> :call ThreadCompile()<CR>
map <F2> :WriterToggle<CR>

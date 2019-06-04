"vim-plug plugins manager
"automatically update vim-plug
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'nvie/vim-flake8'
Plug 'nachumk/systemverilog.vim'
Plug 'nathanaelkane/vim-indent-guides'
"black requires vim python3 support
"Plug 'ambv/black'
"google/yapf uses python parser which breaks on f strings
"need python newer than 3.6.1
Plug 'tell-k/vim-autopep8'

call plug#end()

set encoding=utf8

"Max tabs for some serious editing
set tabpagemax=20

"For colorscheme problems - set initial
colorscheme default

"Disable .swp, use version control systems
set noswapfile

"1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab

"Show current position
set ruler
set number

"Show matching parenthesis
set showmatch

"Graphical autocomplete
set wildmenu

"Statusline always on
set laststatus=2

"Set support for 256 colours in vim for gnome term
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"Indent guides with fixes to gruvbox_light
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=222
let g:indent_guides_enable_on_vim_startup = 1

"Vim autocompletion menu colour
hi Pmenu ctermbg=gray

"Show trailing whitespaces
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>/,trail:-,extends:>,precedes:<,nbsp:+
endif

"Auto indent, smart indent, wrap lines
set si
set ai
filetype plugin indent on
set wrap

"In normal mode (n), non-recursive (nore) always move by 1 line, even with wrapping
nnoremap j gj
nnoremap k gk

"Always leave some lines visible on the screen
set scrolloff=5

"swap ; and : for faster commands
nnoremap ; :

"netrw config
let g:netrw_list_hide = '.*.so,*.swp,*.zip,^\.git$,^\.\.=/\=$'
let g:netrw_banner = 0

"Start netrw explorer instead of welcome screen
"or open the given file
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * if argc()==0 | Explore! | endif
augroup END

"Highlight current line number but no underline
set cursorline
hi clear CursorLine
hi CursorLineNr ctermbg=grey

"Matching parenthesis in standing out color
hi MatchParen cterm=bold ctermbg=grey ctermfg=none

"Python
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au FileType python set foldmethod=indent foldlevel=99

"Flake8
let g:flake8_cmd="/home/pwiecha/.local/bin/flake8"
let g:flake8_show_quickfix=1
"autocmd BufWritePost *.py call flake8#Flake8()

"Autopep8 config
"call :Autopep8 on file
let g:autopep8_max_line_length=79
let g:autopep8_ignore="E402,E226,E228,W503,W391"

"Highlight character in lines exceeding 80 chars
"Usage :call Longlines() or :Lls (aliast below)
let s:longline_flag = 0
function! Longlines()
  if s:longline_flag
    highlight clear ColorColumn
    let s:longline_flag = 0
    echon "Long lines highlight OFF"
  else
    highlight ColorColumn ctermbg=magenta
    call matchadd('ColorColumn', '\%81v', 100)
    let s:longline_flag = 1
    echon "Long lines highlight ON"
  endif
endfunction

fun! Clrwspace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

"user - specific directory shortcuts
"Usage :Cdtb, :Lls
command! Cdtb E /home/pwiecha/dsp_top/tb
command! Lls call Longlines()
command! Clrwspace call Clrwspace()

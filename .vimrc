syntax enable

set encoding=utf8

set tabpagemax=40

"For colorscheme problems
colorscheme default

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

set laststatus=2

"Set support for 256 colours in vim
set t_Co=256
"Indent guides
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
" let g:netrw_list_hide = '.*.so,*.swp,*.zip,^\.git$,^\.\.=/\=$'
let g:netrw_banner = 0

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * if argc()==0 | Explore! | endif
augroup END

"Highlight current line number but no underline
set cursorline
hi clear CursorLine
hi CursorLineNr ctermbg=grey
hi CursorLine cterm=NONE


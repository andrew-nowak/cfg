set nocompatible

" Colours
colorscheme desert
set termguicolors
let &t_ut=''

syntax enable

" Default indenting to 2 spaces
set expandtab
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2
filetype plugin on
filetype plugin indent on
set autoindent
set smarttab

if !&diff
  " Do not close buffers when opening new
  set hidden
endif

" Show line numbers
set number
" Show line numbers relative to current line
"set relativenumber
" Show line and column in status bar
set ruler
" Show current command on status bar
set showcmd
" Show current vim mode
set showmode
" Highlight the matching parenthesis
set showmatch
" Show completion options in the menu
set wildmenu
" Ignores case when searching and search string is lowercase
set ignorecase
set smartcase
set incsearch
" Sets a more descriptive title in the terminal
set title
" g flag is on by default when performing :s
set gdefault
" Enable mouse in terminals
set mouse=a
" Do the correct thing when pressing backspace
set backspace=indent,eol,start
" Understand :W as :w
command! W :w
" Show unwanted whitespace
set listchars=tab:->,trail:·,extends:>
set list!
" Always show statusline
set laststatus=2
" in a gui, use a nice font
set guifont=mononoki\ 10
" no bells
set noeb vb t_vb=

" display colours correctly, even in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"""" OPTIONAL CONFIGS """"
"
" move up/down respecting wrapping
"nnoremap j gj
"nnoremap k gk
"
"" leave insert mode on jj
"inoremap jj <ESC>
"" or jk
"inoremap jk <ESC>

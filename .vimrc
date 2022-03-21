set nocompatible

" don't have vim plug? get it here!
if empty(glob('~/.vim/autoload/plug.vim')) && !&diff
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" do not load plugins when vimdiffing
if filereadable(expand("~/.vim/autoload/plug.vim")) && !&diff
  call plug#begin("~/.vim/plugged")

  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'fidian/hexmode'
  Plug 'airblade/vim-gitgutter'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-dispatch'
  Plug 'junegunn/fzf.vim'

  " Syntax plugins
  Plug 'tpope/vim-cucumber'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'

  " colourscheme
  Plug 'morhetz/gruvbox'

  call plug#end()

  """""""""""""""""""""""""
  ""                     ""
  ""    PLUGIN CONFIG    ""
  ""                     ""
  """""""""""""""""""""""""

  " Colours
  set termguicolors
  set background=dark
  " stop vim erasing background colour
  let &t_ut=''
  colorscheme gruvbox

endif

syntax enable

let mapleader = " "

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
" Ignores case when searching is search string is lowercase
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

" move up/down respecting wrapping
nnoremap j gj
nnoremap k gk

" leave insert mode on jj
inoremap jj <ESC>

" switch between open buffers
map <F7> :bp <CR>
map <F8> :bn <CR>
map <Leader>] :bn <CR>
map <Leader>[ :bp <CR>

nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <Leader>d :execute 'NERDTree ' . getcwd()<CR>
nnoremap <Leader>D :NERDTreeClose<CR>

" display colours correctly, even in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

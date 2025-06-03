set nocompatible

let mapleader = " "
let maplocalleader = " "

if has('nvim')
  :lua require('plugins')
endif

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
inoremap jk <ESC>

" switch between open buffers
nnoremap <F7> :bp <CR>
nnoremap <F8> :bn <CR>
nnoremap <Leader>[ <C-O>
nnoremap <Leader>] <C-I>
nnoremap <Leader>bp :bp<CR>
nnoremap <Leader>bn :bn<CR>
"nnoremap <Leader>[ :bp<CR>
"nnoremap <Leader># :bd<CR>

" toggle comments
nmap <Leader>c gcc
vmap <Leader>c gc

nnoremap <Leader>at 0"=strftime('%a %d %b %Y')<CR>Pa<CR><ESC>O

" display colours correctly, even in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"autocmd VimLeave,VimSuspend * set guicursor=a:ver20
"autocmd VimResume * set guicursor&vim

autocmd FileType xml nnoremap<buffer> <Leader>rf :%!xmllint --format %<CR>

function! FirstAboveInTree()
  let old_search = @/
  let @/ = "^.\\{" . (col('.')-1) . "\\} "
  normal! N
  normal! j
  let @/ = old_search
endfunction

nnoremap <Leader>tp :<C-U>call FirstAboveInTree()<CR>

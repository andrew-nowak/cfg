set nocompatible

let mapleader = " "
" do not load plugins when vimdiffing
if filereadable(expand("~/.local/share/nvim/site/autoload/plug.vim")) && !&diff
  call plug#begin(stdpath('config')."/plugged")

  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'fidian/hexmode'
  Plug 'airblade/vim-gitgutter'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-dispatch'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  " Syntax plugins
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  let g:coc_global_extensions = []

  if isdirectory('./node_modules') && isdirectory('./node_modules/typescript')
    let g:coc_global_extensions += ['coc-tsserver']
    if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
      let g:coc_global_extensions += ['coc-prettier']
    endif

    if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
      let g:coc_global_extensions += ['coc-eslint']
    endif
  endif

  if filereadable('./build.sbt') || filereadable('./build.sc')
    let g:coc_global_extensions += ['coc-metals']
  endif

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gr <Plug>(coc-references)

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <leader>do <Plug>(coc-codeaction)
  nnoremap <leader>rn <Plug>(coc-rename)
  inoremap <silent><expr> <c-space> coc#refresh()


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
nnoremap <Leader>] :bn<CR>
nnoremap <Leader>[ :bp<CR>
nnoremap <Leader># :bd<CR>

nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <Leader>d :execute 'NERDTree ' . getcwd()<CR>
nnoremap <Leader>D :NERDTreeClose<CR>

nnoremap <Leader><Leader> :Files<CR>
nnoremap <Leader>f :RG<CR>

" display colours correctly, even in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

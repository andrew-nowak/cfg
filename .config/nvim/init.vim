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

  Plug 'nvim-lua/plenary.nvim'
  Plug 'scalameta/nvim-metals'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  "Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "let g:coc_global_extensions = []

  "if isdirectory('./node_modules') && isdirectory('./node_modules/typescript')
    "let g:coc_global_extensions += ['coc-tsserver']
    "if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
      "let g:coc_global_extensions += ['coc-prettier']
    "endif

    "if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
      "let g:coc_global_extensions += ['coc-eslint']
    "endif
  "endif

  "inoremap <silent><expr> <TAB>
        "\ pumvisible() ? "\<C-n>" :
        "\ <SID>check_back_space() ? "\<TAB>" :
        "\ coc#refresh()
  "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  "nnoremap <silent> K :call <SID>show_documentation()<CR>

  "function! s:show_documentation()
    "if (index(['vim','help'], &filetype) >= 0)
      "execute 'h '.expand('<cword>')
    "else
      "call CocAction('doHover')
    "endif
  "endfunction

  "function! s:check_back_space() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~# '\s'
  "endfunction

  "" Make <CR> auto-select the first completion item and notify coc.nvim to
  "" format on enter, <cr> could be remapped by other vim plugin
  "inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  "nmap <silent> gd <Plug>(coc-definition)
  "nmap <silent> gy <Plug>(coc-type-definition)
  "nmap <silent> gr <Plug>(coc-references)

  "nmap <silent> [g <Plug>(coc-diagnostic-prev)
  "nmap <silent> ]g <Plug>(coc-diagnostic-next)
  "nmap <leader>do <Plug>(coc-codeaction)
  "nnoremap <leader>rn <Plug>(coc-rename)
  "inoremap <silent><expr> <c-space> coc#refresh()

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

nnoremap <Leader>at 0"=strftime('%a %d %b %Y')<CR>Pa<CR><ESC>O


"-----------------------------------------------------------------------------
" nvim-lsp Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
"nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>a   <cmd>lua require'metals'.open_all_diagnostics()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>

:lua << EOF
local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone'
  },
  mapping = cmp.mapping.preset.insert({
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- I use tabs... some say you should stick to ins-completion but this is just here as an example
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }),
})

----------------------------------
-- LSP Setup ---------------------
----------------------------------
local metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
local capabilities = vim.lsp.protocol.make_client_capabilities()
metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)


metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})


EOF

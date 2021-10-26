"# Plugins
call plug#begin('~/.vim/plugged')
"## IDE Experience
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'preservim/nerdcommenter'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'puremourning/vimspector'
Plug 'sirver/ultisnips'
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
Plug 'tpope/vim-fugitive'
Plug 'skywind3000/asyncrun.vim'
Plug 'folke/which-key.nvim'
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-treesitter/playground'

"## Neovim apps 
Plug 'iamcco/markdown-preview.nvim'
Plug 'rhysd/vim-grammarous'
Plug 'sotte/presenting.vim'

"## Themes
Plug 'chriskempson/base16-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'shaunsingh/nord.nvim'
Plug 'b4skyx/serenade'
Plug 'dracula/vim' 
Plug 'EdenEast/nightfox.nvim'

"## Ricing
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'

"## Syntax
Plug 'bohlender/vim-smt2' 
Plug 'plasticboy/vim-markdown'
call plug#end()

"# Settings

"## General
let mapleader = " "
nnoremap <C-t> <cmd>terminal<CR>
nnoremap <leader>sv :source $HOME/.config/nvim/init.vim<CR>
nnoremap <leader>rs :call UltiSnips#RefreshSnippets()<CR>
nnoremap <leader>cd <cmd>cd %:p:h<CR><cmd>pwd<CR>
function! SaveSession()
  :mksession! session
  :echon "Session saved"
endfunction
nnoremap <leader>ss <cmd>call SaveSession()<CR>

"## Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"## Windows
nnoremap <silent> <leader>u <cmd>exe "resize -5" <CR>
nnoremap <silent> <leader>i <cmd>exe "resize +5" <CR>
nnoremap <silent> <leader>y <cmd>exe "vertical resize +5"<CR>
nnoremap <silent> <leader>o <cmd>exe "vertical resize -5"<CR>

"## Telescope bindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>gg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
nnoremap <leader>hh <cmd>Telescope help_tags<cr>

"## Buffers
nnoremap <silent> [b <cmd>bprevious<CR>
nnoremap <silent> ]b <cmd>bnext<CR>
nnoremap <silent> [B <cmd>bfirst<CR>
nnoremap <silent> ]B <cmd>bblast<CR>

"## FZF binders
nnoremap <CR> <cmd>FZF<CR>

"## NerdToggle binders
nnoremap <C-n> <cmd>NERDTreeToggle<CR>

"## Snippets using ultisnips
let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"## Vimtex setup
let g:Tex_DefaultTargetFormat = 'pdf'
let g:vimtex_view_enabled = 1
let g:vimtex_view_automatic = 0
" Using zathura
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_zathura = 1
let g:vimtex_view_automatic_xwin = 1
let g:vimtex_view_forward_search_on_start = 1
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = "latex"
let g:active_refresh = 0

function! ToggleActiveRefresh()
  if g:active_refresh == 1
    let g:active_refresh = 0
  else
    let g:active_refresh = 1
  endif
endfunction
nnoremap <silent> <leader>ar <cmd>call ToggleActiveRefresh()<cr>

function! TexRefresh()
  if !filereadable(expand("main.pdf"))
    :silent make
  else
    :AsyncRun make
  endif
  :VimtexView
endfunction
function! ActiveRefresh()
  if g:active_refresh == 1
    call TexRefresh()
  endif
endfunction
autocmd BufWritePost *.tex :call ActiveRefresh()
function! TexLeave()
  :silent !make clean
  :call SaveSession()
endfunction
autocmd VimLeavePre *.tex :call TexLeave()

"## Fugitive settings:
nmap <leader>gs <cmd>G<CR>
nmap <leader>gj <cmd>diffget //3<CR>
nmap <leader>gf <cmd>diffget //2<CR>

"## SMT settings:
let g:smt2_solver_command = "z3 -smt2"
let g:smt2_solver_version_switch = "4.8.8"

"## Lightline settings:
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
          \   'readonly': 'IsActiveRefresh',
          \   'gitbranch': 'FugitiveHead'
          \ },
          \ }
function! IsActiveRefresh()
  if g:active_refresh == 1
    return 'Active Refresh'
  else
    return ''
  endif
endfunction

"## Neovim binders
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc> 
endif

if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

"## Customization
syntax on
set mouse=a
set timeoutlen=1000 ttimeoutlen=0
set clipboard=unnamedplus
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set smartcase
set noswapfile
set nobackup
set undofile
set incsearch 
set number relativenumber
set nu rnu
set encoding=UTF-8

let base16colorspace = 256
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors') 
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection = '0'
color tokyonight
set termguicolors
set guifont=InputMono\ NF:h30
"highlight Normal cterm=NONE ctermbg=none gui=NONE guibg=NONE

augroup custom_term
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END

"## Autocompleting configuration
set completeopt=menuone,noinsert,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']

"## Compe configuration
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

"## LSP Install config
lua require('lsp-install-config')

"## LSP config:
lua require('lsp-config')

"## Nvim-treesitter config
lua require('nvim-treesitter-config')

"## Which-keys setup
lua require('which-key-config')

"## Wilder setup
call wilder#setup({
      \'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \})
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'fuzzy': 1,
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': wilder#python_fuzzy_pattern(),
      \       'sorter': wilder#python_difflib_sorter(),
      \       'engine': 're',
      \     }),
      \   ),
      \ ])
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'highlights': {
        \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
        \ },
        \ }))

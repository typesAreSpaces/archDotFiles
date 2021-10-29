"# Pluggins
lua require('plugins')

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

"# Settings
lua require('settings')

"# Snippets using ultisnips
lua require('ultisnips')

"# Vimtex setup
lua require('tex') 

"# SMT settings:
let g:smt2_solver_command = "z3 -smt2"
let g:smt2_solver_version_switch = "4.8.8"

"# Lightline settings:
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

"# Neovim binders
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc> 
endif

if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

"# Customization
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

"# Autocompleting configuration
set completeopt=menuone,noinsert,noselect
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']

"# Compe configuration
lua require('compe-config')

"# LSP Install config
lua require('lsp-install-config')

"# LSP config:
lua require('lsp-config')

"# Nvim-treesitter config
lua require('nvim-treesitter-config')

"# Which-keys setup
lua require('which-key-config')

"# Wilder setup
lua require('wilder-setup')

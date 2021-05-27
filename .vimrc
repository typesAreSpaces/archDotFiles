"# Plugins
call plug#begin('~/.vim/plugged')
"IDE Experience
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'rhysd/vim-grammarous'
Plug 'iamcco/markdown-preview.nvim'
Plug 'preservim/nerdtree'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'preservim/nerdcommenter'
Plug 'godlygeek/tabular'

"## Themes
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'b4skyx/serenade'
Plug 'dracula/vim' 

"## Ricing
Plug 'itchyny/lightline.vim'

"## Syntax
Plug 'bohlender/vim-smt2' 
Plug 'plasticboy/vim-markdown'
call plug#end()

"# Vim settings
let mapleader=" "

"## Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"## Windows
nnoremap <silent> <leader>u :exe "resize -5" <CR>
nnoremap <silent> <leader>i :exe "resize +5" <CR>
nnoremap <silent> <leader>y :exe "vertical resize +5"<CR>
nnoremap <silent> <leader>o :exe "vertical resize -5"<CR>

"## Buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :bblast<CR>

"# FZF binders
nnoremap <CR> :FZF<CR>

"# NerdToggle binders
nnoremap <C-n> :NERDTreeToggle<CR>

"# SMT settings:
let g:smt2_solver_command="z3 -smt2"
let g:smt2_solver_version_switch="4.8.8"

"# Lightline settings:
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

"# Customization
let base16colorspace=256  
set background=dark

"colorscheme dracula
colorscheme serenade

syntax on
set timeoutlen=1000 ttimeoutlen=0
set clipboard=unnamedplus
set number relativenumber
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu rnu
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch 

highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight Normal ctermbg=none
highlight NonText ctermbg=none

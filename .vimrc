syntax on

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'b4skyx/serenade'
Plug 'dracula/vim' 
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'mbbill/undotree'
Plug 'bohlender/vim-smt2' 
Plug 'vim-latex/vim-latex'
Plug 'FStarLang/VimFStar', {'for': 'fstar'}
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'neovimhaskell/haskell-vim'
Plug 'rhysd/vim-grammarous'
Plug 'iamcco/markdown-preview.nvim'

call plug#end()

let mapleader=" "

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :bblast<CR>

nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>l :ls<CR>
nnoremap <silent> <leader>gr :YcmCompleter GoToReferences<CR>

nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>

nnoremap <silent> <leader>u :exe "resize -5" <CR>
nnoremap <silent> <leader>i :exe "resize +5" <CR>
nnoremap <silent> <leader>y :exe "vertical resize +5"<CR>
nnoremap <silent> <leader>o :exe "vertical resize -5"<CR>

nnoremap <CR> :<C-u>FZF<CR>

let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark

"colorscheme dracula
colorscheme serenade

if executable('rg')
  let g:rg_derive_root='true'
end

let g:smt2_solver_command="z3 -smt2"
let g:smt2_solver_version_switch="4.8.8"

set laststatus=2
nnoremap <C-n> :NERDTreeToggle<CR>

set timeoutlen=1000 ttimeoutlen=0
set clipboard=unnamedplus

set number relativenumber
set nu rnu

highlight Normal ctermbg=none
"highlight NonText ctermbg=none

let g:coc_enabled=0
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

autocmd BufNew,BufEnter * execute "silent! CocDisable"
autocmd BufLeave * execute "silent! CocDisable"

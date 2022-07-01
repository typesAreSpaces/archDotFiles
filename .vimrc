let mapleader=" "

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap <C-G> <ESC>

nnoremap <silent> <leader>u :exe "resize -5" <CR>
nnoremap <silent> <leader>i :exe "resize +5" <CR>
nnoremap <silent> <leader>y :exe "vertical resize +5"<CR>
nnoremap <silent> <leader>o :exe "vertical resize -5"<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :bblast<CR>

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
set undofile
set incsearch 

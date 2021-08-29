call plug#begin('~/.vim/plugged')
"# IDE Experience
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/limelight.vim'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'puremourning/vimspector'
Plug 'sirver/ultisnips'
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
Plug 'sainnhe/gruvbox-material'

"# Neovim apps 
Plug 'iamcco/markdown-preview.nvim'
Plug 'rhysd/vim-grammarous'
Plug 'sotte/presenting.vim'

"# Themes
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'b4skyx/serenade'
Plug 'dracula/vim' 
Plug 'EdenEast/nightfox.nvim'

"# Ricing
Plug 'itchyny/lightline.vim'

"# Syntax
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

"# Telescope utilities 
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"# NerdToggle binders
nnoremap <C-n> :NERDTreeToggle<CR>

"# Snippets using ultisnips
let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

"# Latex setup
let g:Tex_DefaultTargetFormat='pdf'
let g:vimtex_view_enabled=1
let g:vimtex_view_automatic=1
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor = "latex"
autocmd BufWritePost *.tex :VimtexView

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

"work in progress
""# Limelight configuration

"" Color name (:help cterm-colors) or ANSI code
"let g:limelight_conceal_ctermfg = 'gray'
"let g:limelight_conceal_ctermfg = 240

"" Color name (:help gui-colors) or RGB color
"let g:limelight_conceal_guifg = 'DarkGray'
"let g:limelight_conceal_guifg = '#777777'

"" Default: 0.5
"let g:limelight_default_coefficient = 0.7

"" Number of preceding/following paragraphs to include (default: 0)
"let g:limelight_paragraph_span = 1

"" Beginning/end of paragraph
""   When there's no empty line between the paragraphs
""   and each paragraph starts with indentation
"let g:limelight_bop = '^\s'
"let g:limelight_eop = '\ze\n^\s'

"" Highlighting priority (default: 10)
""   Set it to -1 not to overrule hlsearch
"let g:limelight_priority = -1

""--------------------------------------------------------------------------------
""MAPPINGS{{{
""--------------------------------------------------------------------------------
"" limelight works on ranges. Declare limelight to bein on content of current line
"nnoremap <space>lb :let g:limelight_bop='^'.getline('.').'$'<cr>
"" limelight works on ranges. Declare limelight to end on contents of current line
"nnoremap <space>le :let g:limelight_eop='^'.getline('.').'$'<cr>
""decrement
"nnoremap <space>ld :call SetLimeLightIndent(g:limelightindent - 4)<cr>
""increment
"nnoremap <space>li :call SetLimeLightIndent(g:limelightindent + 4)<cr>
""reset indent to default 4
"nnoremap <space>lr :call SetLimeLightIndent(4)<cr>
"" set limelight toggle
"noremap <space>ls :call SetLimeLightIndent(8) 
"nnoremap <space>lt :Limelight!!<cr>

""-----------------------------------------------------------------------------}}}
""FUNCTIONS{{{
""--------------------------------------------------------------------------------
"let g:limelightindent=4
"function! LimeLightExtremeties()
"let limelight_start_stop='^\s\{0,'.g:limelightindent.'\}\S'
"let g:limelight_eop=limelight_start_stop
"let g:limelight_bop=limelight_start_stop
"Limelight!!
"Limelight!!
"echo 'limelightindent = '.g:limelightindent
"endfunction
"function! SetLimeLightIndent(count)
"let g:limelightindent = a:count
"if(g:limelightindent < 0)
"g:limelightindent = 0
"endif
"call LimeLightExtremeties()
"endfunction
""-----------------------------------------------------------------------------}}}
"command! -nargs=*  SetLimeLightIndent call SetLimeLightIndent(<args>)

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
let base16colorspace=256  
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

if has('termguicolors')
  set termguicolors
endif
set background=dark

let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material

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

augroup custom_term
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END

highlight ColorColumn ctermbg=0 guibg=lightgrey
highlight Normal ctermbg=none
highlight NonText ctermbg=none

"# Autocompleting configuration
set completeopt=menuone,noinsert,noselect
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"# Compe configuration
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

"# LSP Install config
lua << EOF
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  print(server)
  require'lspconfig'[server].setup{}
end
EOF

"# LSP config
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an custom_on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({ 
  on_attach = custom_on_attach 
  })
end
EOF

"# LSP config
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an custom_on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local custom_on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', 'gK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({ 
  on_attach = custom_on_attach 
  })
end
EOF

"## Nvim-treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained",
ignore_install = {},
highlight = {
enable = true, 
disable = {},
additional_vim_regex_highlighting = false,
},
}
EOF

vim.g.mapleader = " "

local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap=true, silent=true }

-- # General
set_keymap('n', '<C-t>', '<cmd>terminal<CR>', opts)
set_keymap('n', '<leader>sv', '<cmd>source $HOME/.config/nvim/init.vim<CR>', opts)
set_keymap('n', '<leader>rs', '<cmd>call UltiSnips#RefreshSnippets()<CR>', opts)
set_keymap('n', '<leader>cd', '<cmd>cd %:p:h<CR><cmd>pwd<CR>', opts)
set_keymap('n', '<leader>ss', '<cmd>mksession! session<CR><cmd>echon "Session saved"<CR>', opts)

-- # Navigation
set_keymap('n', '<C-j>', '<C-w><C-j>', opts)
set_keymap('n', '<C-k>', '<C-w><C-k>', opts)
set_keymap('n', '<C-l>', '<C-w><C-l>', opts)
set_keymap('n', '<C-h>', '<C-w><C-h>', opts)

-- # Windows
set_keymap('n', '<leader>u', '<cmd>exe "resize -5" <CR>', opts)
set_keymap('n', '<leader>i', '<cmd>exe "resize +5" <CR>', opts)
set_keymap('n', '<leader>y', '<cmd>exe "vertical resize +5"<CR>', opts)
set_keymap('n', '<leader>o', '<cmd>exe "vertical resize -5"<CR>', opts)

-- # Buffers
set_keymap('n', '[b', '<cmd>bprevious<CR>', opts)
set_keymap('n', ']b', '<cmd>bnext<CR>', opts)
set_keymap('n', '[B', '<cmd>bfirst<CR>', opts)
set_keymap('n', ']B', '<cmd>bblast<CR>', opts)

-- # FZF binders
set_keymap('n', '<CR>', '<cmd>FZF<CR>', opts)

-- # NerdToggle binders
set_keymap('n', '<C-n>', '<cmd>NERDTreeToggle<CR>', opts)

-- # Fugitive settings:
set_keymap('n', '<leader>gs', '<cmd>G<CR>', opts)
set_keymap('n', '<leader>gj', '<cmd>diffget //3<CR>', opts)
set_keymap('n', '<leader>gf', '<cmd>diffget //2<CR>', opts)

vim.cmd([[
augroup custom_term
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber bufhidden=hide
augroup END
]])

set_keymap('t', '<Esc>', '<C-\\><C-n>', opts)
set_keymap('t', '<C-v><Esc>', '<Esc>', opts)

vim.cmd([[
highlight! link TermCursor Cursor
highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
]])

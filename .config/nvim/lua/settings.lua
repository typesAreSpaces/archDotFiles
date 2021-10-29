vim.g.mapleader = " "

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local opts = { noremap=true, silent=true }

-- # General
buf_set_keymap('n', '<C-t>', '<cmd>terminal<CR>', opts)
buf_set_keymap('n', '<leader>sv', '<cmd>source $HOME/.config/nvim/init.vim<CR>', opts)
buf_set_keymap('n', '<leader>rs', '<cmd>call UltiSnips#RefreshSnippets()<CR>', opts)
buf_set_keymap('n', '<leader>cd', '<cmd>cd %:p:h<CR><cmd>pwd<CR>', opts)
buf_set_keymap('n', '<leader>ss', '<cmd>mksession! session<CR><cmd>echon "Session saved"<CR>', opts)

-- # Navigation
buf_set_keymap('n', '<C-J>', '<C-W><C-J>', opts)
buf_set_keymap('n', '<C-K>', '<C-W><C-K>', opts)
buf_set_keymap('n', '<C-L>', '<C-W><C-L>', opts)
buf_set_keymap('n', '<C-H>', '<C-W><C-H>', opts)

-- # Windows
buf_set_keymap('n', '<leader>u', '<cmd>exe "resize -5" <CR>', opts)
buf_set_keymap('n', '<leader>i', '<cmd>exe "resize +5" <CR>', opts)
buf_set_keymap('n', '<leader>y', '<cmd>exe "vertical resize +5"<CR>', opts)
buf_set_keymap('n', '<leader>o', '<cmd>exe "vertical resize -5"<CR>', opts)

-- # Buffers
buf_set_keymap('n', '[b', '<cmd>bprevious<CR>', opts)
buf_set_keymap('n', ']b', '<cmd>bnext<CR>', opts)
buf_set_keymap('n', '[B', '<cmd>bfirst<CR>', opts)
buf_set_keymap('n', ']B', '<cmd>bblast<CR>', opts)

-- # FZF binders
buf_set_keymap('n', '<CR>', '<cmd>FZF<CR>', opts)

-- # NerdToggle binders
buf_set_keymap('n', '<C-n>', '<cmd>NERDTreeToggle<CR>', opts)

-- # Telescope bindings
buf_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
buf_set_keymap('n', '<leader>gg', '<cmd>Telescope live_grep<CR>', opts)
buf_set_keymap('n', '<leader>bb', '<cmd>Telescope buffers<CR>', opts)
buf_set_keymap('n', '<leader>hh', '<cmd>Telescope help_tags<CR>', opts)

-- # Fugitive settings:
buf_set_keymap('n', '<leader>gs', '<cmd>G<CR>', opts)
buf_set_keymap('n', '<leader>gj', '<cmd>diffget //3<CR>', opts)
buf_set_keymap('n', '<leader>gf', '<cmd>diffget //2<CR>', opts)

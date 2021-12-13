-- Settings

function _G.change_kbd()
  local is_caps_escape_key = vim.fn.system('xmodmap | grep lock | grep 0x9')
  if (is_caps_escape_key == nil or is_caps_escape_key  == '') then
    vim.cmd('silent !changeKBD ESC')
  else
    vim.cmd('silent !changeKBD CTRL')
  end
end

local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap=true, silent=true }

-- # General
set_keymap('n', '<C-g>', '<Esc>', opts)
set_keymap('v', '<C-g>', '<Esc>gV', opts)
set_keymap('o', '<C-g>', '<Esc>', opts)
set_keymap('c', '<C-g>', '<C-c><Esc>', opts)
set_keymap('i', '<C-g>', '<Esc>', opts)

set_keymap('n', '<C-t>', '<cmd>terminal<CR>', opts)
set_keymap('n', '<leader>sv', '<cmd>source $HOME/.config/nvim/init.vim<CR><cmd>echon "Config sourced"<CR>', opts)
set_keymap('n', '<leader>rs', '<cmd>call UltiSnips#RefreshSnippets()<CR><cmd>echon "Snippets refreshed"<CR>', opts)
set_keymap('n', '<leader>cd', '<cmd>cd %:p:h<CR><cmd>pwd<CR>', opts)
set_keymap('n', '<leader>ss', '<cmd>mksession! session<CR><cmd>echon "Session saved"<CR>', opts)

-- # Navigation
set_keymap('n', '<C-j>', '<C-w><C-j>', opts)
set_keymap('n', '<C-k>', '<C-w><C-k>', opts)
set_keymap('n', '<C-l>', '<C-w><C-l>', opts)
set_keymap('n', '<C-h>', '<C-w><C-h>', opts)
set_keymap('n', '<leader>j', '<cmd>BookmarkNext<CR>', opts)
set_keymap('n', '<leader>k', '<cmd>BookmarkPrev<CR>', opts)

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

-- # Terminal:
set_keymap('t', '<Esc>', '<C-\\><C-n>', opts)
set_keymap('t', '<C-v><Esc>', '<Esc>', opts)

-- # Telescope bindings:
set_keymap('n', '<CR>', '<cmd>Telescope find_files prompt_prefix=🔍<CR>', opts)

-- # System bindings:
set_keymap('n', '<leader>ck', '<cmd>lua change_kbd()<CR>', opts)

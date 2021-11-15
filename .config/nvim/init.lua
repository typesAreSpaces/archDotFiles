-- A method to dump an object and print it out
function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

-- # Pluggins
require('plugins')

-- # Settings
require('settings')

-- # Mappings
require('mappings')

-- # Telescope
require('telescope-config')

-- # Snippets using ultisnips
require('ultisnips')

-- # Vimtex setup
require('tex') 

-- # SMT settings:
require('smt2')

-- # Lualine settings:
require('lualine-config')

-- # Customization
require('customization')

-- # Cmp configuration
require('cmp-config')

-- # LSP Install config
require('lsp-install-config')

-- # LSP config:
require('lsp-config')

-- # Nvim-treesitter config
require('nvim-treesitter-config')

-- # Which-keys setup
require('which-key-config')

-- # Wilder setup
require('wilder-setup')

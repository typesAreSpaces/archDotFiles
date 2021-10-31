local function set_keymap(...) vim.api.nvim_set_keymap(...) end
local opts = { noremap=true, silent=true }

vim.g.Tex_DefaultTargetFormat = 'pdf'
vim.g.vimtex_view_enabled = 1
vim.g.vimtex_view_automatic = 0
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_zathura = 1
vim.g.vimtex_view_automatic_xwin = 1
vim.g.vimtex_view_forward_search_on_start = 1
vim.g.vimtex_compiler_progname = 'nvr'
vim.g.tex_flavor = "latex"
vim.g.active_refresh = 0

function ToggleActiveRefresh()
  if vim.g.active_refresh == 1 then
    vim.g.active_refresh = 0
  else
    vim.g.active_refresh = 1
  end
end

set_keymap('n', '<leader>ar', '<cmd>lua ToggleActiveRefresh()<CR>', opts)

function TexRefresh()
  local f=io.open("main.pdf","r")
  if f~=nil then 
    io.close(f) 
    vim.cmd('AsyncRun make')
  else 
    vim.cmd('silent make')
  end
  vim.cmd('VimtexView')
end

function ActiveRefresh()
  if vim.g.active_refresh == 1 then 
    TexRefresh()
  end
end
vim.cmd('autocmd BufWritePost *.tex lua ActiveRefresh()')

function SaveSession()
  vim.cmd('mksession! session')
  vim.cmd('echon "Session saved"')
end

function TexLeave()
  vim.cmd('silent !make clean')
  SaveSession()
end

vim.cmd('autocmd VimLeave *.tex lua TexLeave()')
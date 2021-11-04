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
vim.g.xwindow_id = vim.fn.system('xdotool getactivewindow')

--vim.cmd([[
--function! MyHook()
  --silent call system('xdotool windowactivate ' . g:xwindow_id . ' --sync')
--endfunction
--]])

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
vim.cmd('autocmd Filetype tex set tw=80')

function SaveSession()
  vim.cmd('mksession! session')
  vim.cmd('echon "Session saved"')
end

function TexLeave()
  vim.cmd('silent !make clean')
  SaveSession()
end

vim.cmd('autocmd VimLeave *.tex lua TexLeave()')

-- TODO
function CloseViewers()
  if vim.fn.executable('xdotool') == 1 
    and vim.fn.exists('b:vimtex') == 1 
    and vim.fn.exists('b:vimtex.viewer') == 1 
    and vim.b.vimtex.viewer.xwin_id ~= nil
    then
    --local xwin_viewer_id = vim.fn.system(string.format("xdotool search --name \"main.pdf\""))
    --vim.fn.system(string.format("xdotool windowactivate --sync %s key --clearmodifiers --delay 0 'ctrl+q'", xwin_viewer_id))
    local what = vim.fn.system(
    string.format("xdotool windowactivate --sync %d key --clearmodifiers --delay 1 'ctrl+q'", vim.b.vimtex.viewer.xwin_id))
  end
end

--vim.cmd([[
--augroup vimtex_event_2
  --au!
  --au User VimtexEventQuit lua CloseViewers()
--augroup END
--]])

vim.cmd('filetype plugin indent on')

vim.g.Tex_DefaultTargetFormat = 'pdf'
vim.g.vimtex_view_enabled = 1
vim.g.vimtex_view_automatic = 1
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_view_zathura = 1
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
vim.cmd('autocmd Filetype tex set colorcolumn=80')

function SaveSession()
  vim.cmd('mksession! session')
  vim.cmd('echon "Session saved"')
end

function TexLeave()
  vim.cmd('silent !make clean')
  SaveSession()
end

vim.cmd('autocmd VimLeave *.tex lua TexLeave()')

function CloseViewers()
  if vim.fn.executable('xdotool') == 1 
    and vim.fn.executable('xlsw') == 1 then
    local search_cmd="!xlsw | grep main.pdf | awk '{print $1}'"
    local close_cmd="while read _windowID; do xdotool windowClose \"${_windowID}\"; done"
    vim.cmd(search_cmd .. "|" .. close_cmd)
  end
end

vim.cmd([[
augroup vimtex_close_viewers_on_exit_event
au!
au User VimtexEventQuit lua CloseViewers()
augroup END
]])

function ParentFile()
  local file_name = vim.fn.expand('%:t')
  vim.cmd(string.format("silent grep -w \"input{%s}\" *.tex", string.sub(file_name, 0, -5)))
end

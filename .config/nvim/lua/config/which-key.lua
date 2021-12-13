local wk = require("which-key")
wk.setup {
  plugins = {
    marks = false,
    registers = false,
    spelling = {enabled = false, suggestions = 20},
    presets = {operators = false, motions = false, text_objects = false, windows = false, nav = false, z = false, g = false}
  }
}
--local Terminal = require('toggleterm.terminal').Terminal
--local toggle_float = function()
  --local float = Terminal:new({direction = "float"})
  --return float:toggle()
--end
--local toggle_lazygit = function()
  --local lazygit = Terminal:new({cmd = 'lazygit', direction = "float"})
  --return lazygit:toggle()
--end
local mappings = {
  g = {
    name = "Fugitive Git",
    s = {"<cmd>G<CR>", "Git Status"},
    j = {"<cmd>diffget //3<cr>", "Git master"},
    f = {"<cmd>diffget //2<cr>", "Git HEAD"},
  },
  t = {
    name = "Telescope",
    f = {"<cmd>Telescope file_browser prompt_prefix=🔍<CR>", "File Browser"},
    g = {"<cmd>Telescope live_grep<CR>", "Live Grep"},
    b = {'<cmd>Telescope buffers <CR>', "Buffers"},
    h = {'<cmd>Telescope help_tags<CR>', "Help Tags"},
  },
  --t = {t = {":ToggleTerm<cr>", "Split Below"}, f = {toggle_float, "Floating Terminal"}, l = {toggle_lazygit, "LazyGit"}},
  l = {
    name = "LSP",
    i = {":LspInfo<cr>", "Connected Language Servers"},
    k = {"<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help"},
    K = {'<cmd>lua vim.lsp.buf.hover()<CR>', "Hover Commands"},
    w = {'<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', "Add Workspace Folder"},
    W = {'<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', "Remove Workspace Folder"},
    l = {'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', "List Workspace Folders"},
    t = {'<cmd>lua vim.lsp.buf.type_definition()<cr>', "Type Definition"},
    d = {'<cmd>lua vim.lsp.buf.definition()<cr>', "Go To Definition"},
    D = {'<cmd>lua vim.lsp.buf.declaration()<cr>', "Go To Declaration"},
    r = {'<cmd>lua vim.lsp.buf.references()<cr>', "References"},
    R = {'<cmd>lua vim.lsp.buf.rename()<CR>', "Rename"},
    a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', "Code Action"},
    e = {'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', "Show Line Diagnostics"},
    n = {'<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', "Go To Next Diagnostic"},
    N = {'<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', "Go To Previous Diagnostic"},
  },
  v = {
    name = "VimTex",
    a = {"<cmd>lua ToggleActiveRefresh()<CR>", "Toggle Active Refresh"},
    f = {"<cmd>lua ParentFile()<CR><CR>", "Go to Parent File"},
  }
}

local opts = {prefix = '<leader>'}
wk.register(mappings, opts)

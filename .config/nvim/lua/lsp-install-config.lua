local lsp_install = require('lspinstall')
local nvim_lsp = require('lspconfig')
lsp_install.setup()

local servers = lsp_install.installed_servers()
for _, server in pairs(servers) do
  nvim_lsp[server].setup{}
end

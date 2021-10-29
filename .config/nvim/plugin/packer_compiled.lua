-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jose/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/jose/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/jose/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/jose/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jose/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/asyncrun.vim"
  },
  ["base16-vim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/base16-vim"
  },
  fzf = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["gruvbox-material"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/gruvbox-material"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  ["neovim-remote"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/neovim-remote"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  nerdtree = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nightfox.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nightfox.nvim"
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nord.nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    commands = { "PackerCompile", "PackerInstall", "PackerUpdate", "PackerClean", "PackerSync", "PackerLoad" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/jose/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["presenting.vim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/presenting.vim"
  },
  serenade = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/serenade"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/undotree"
  },
  vim = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-grammarous"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim-grammarous"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim-markdown"
  },
  ["vim-numbertoggle"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim-numbertoggle"
  },
  ["vim-smt2"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim-smt2"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  vimspector = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vimspector"
  },
  vimtex = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/vimtex"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["wilder.nvim"] = {
    loaded = true,
    path = "/home/jose/.local/share/nvim/site/pack/packer/start/wilder.nvim"
  }
}

time([[Defining packer_plugins]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerClean lua require("packer.load")({'packer.nvim'}, { cmd = "PackerClean", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerSync lua require("packer.load")({'packer.nvim'}, { cmd = "PackerSync", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerLoad lua require("packer.load")({'packer.nvim'}, { cmd = "PackerLoad", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerCompile lua require("packer.load")({'packer.nvim'}, { cmd = "PackerCompile", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerInstall lua require("packer.load")({'packer.nvim'}, { cmd = "PackerInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file PackerUpdate lua require("packer.load")({'packer.nvim'}, { cmd = "PackerUpdate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_url = 'https://github.com/wbthomason/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- # Packer can manage itself
  use { 'wbthomason/packer.nvim', 
  cmd = { 'PackerCompile', 'PackerInstall', 'PackerUpdate', 'PackerClean', 'PackerSync', 'PackerLoad' } }

  -- # IDE Experience
  use 'neovim/nvim-lspconfig'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'hrsh7th/nvim-compe'
  use 'mbbill/undotree'
  use { 'junegunn/fzf', run = function() fn['fzf#install'](0) end }
  use 'preservim/nerdtree'
  use 'jeffkreeftmeijer/vim-numbertoggle'
  use 'preservim/nerdcommenter'
  use 'kabouzeid/nvim-lspinstall'
  use 'puremourning/vimspector'
  use 'sirver/ultisnips'
  use 'lervag/vimtex'
  use 'mhinz/neovim-remote'
  use 'tpope/vim-fugitive'
  use 'skywind3000/asyncrun.vim'
  use 'folke/which-key.nvim'
  use { 'gelguy/wilder.nvim', run = ':UpdateRemotePlugins'}
  use 'nvim-treesitter/playground'

  -- # Neovim apps 
  use 'iamcco/markdown-preview.nvim'
  use 'rhysd/vim-grammarous'
  use 'sotte/presenting.vim'

  -- # Themes
  use 'chriskempson/base16-vim'
  use 'sainnhe/gruvbox-material'
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use 'shaunsingh/nord.nvim'
  use 'b4skyx/serenade'
  use 'dracula/vim' 
  use 'EdenEast/nightfox.nvim'

  -- # Ricing
  use 'mhinz/vim-startify'
  use 'itchyny/lightline.vim'
  use 'ryanoasis/vim-devicons'

  -- # Syntax
  use 'bohlender/vim-smt2' 
  use 'plasticboy/vim-markdown'
end)

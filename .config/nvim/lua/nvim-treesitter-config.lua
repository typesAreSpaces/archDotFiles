require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  ignore_install = {},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "ti",
      node_incremental = "tn",
      scope_incremental = "tt",
      node_decremental = "tm",
    },
  },
  highlight = {
    enable = true, 
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}


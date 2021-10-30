-- TODO: Refactor this

vim.cmd("call wilder#setup({'modes': [':', '/', '?'], 'next_key': '<Tab>', 'previous_key': '<S-Tab>', 'accept_key': '<Down>', 'reject_key': '<Up>'})")

vim.cmd("call wilder#set_option('pipeline', [wilder#branch(wilder#cmdline_pipeline({'language': 'python','fuzzy': 1,}),wilder#python_search_pipeline({'pattern': wilder#python_fuzzy_pattern(), 'sorter': wilder#python_difflib_sorter(),'engine': 're',}),),])")

vim.cmd("call wilder#set_option('renderer', wilder#popupmenu_renderer({'highlighter': wilder#basic_highlighter(),'highlights': {'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),},}))")

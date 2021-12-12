local function IsActiveRefresh()
  if vim.g.active_refresh == 1 then
    return [[Active Refresh]]
  else
    return [[]]
  end
end

local function IsKBDs()

  local is_caps_escape_key = vim.fn.system('xmodmap | grep lock | grep 0x9')
  local is_caps_ctrl_key = vim.fn.system('xmodmap | grep lock | grep 0x69')

  if (is_caps_escape_key == nil or is_caps_escape_key  == '') then
    if (is_caps_ctrl_key == nil or is_caps_ctrl_key  == '') then
      return [[]]
    else
      return [[Caps is Ctrl]]
    end
  else
    return [[Caps is Esc]]
  end
end

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { { 'filename', file_status = true, path = 0 }, IsActiveRefresh, IsKBDs },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

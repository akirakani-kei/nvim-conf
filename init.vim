source ~/.config/nvim/vim-plug/plugins.vim
source ~/.config/nvim/keybinds.vim

lua require'nvim-tree'.setup {}

set clipboard+=unnamedplus
set timeoutlen=250

autocmd VimEnter * set nu
autocmd VimEnter * set noshowmode
autocmd VimEnter * set noruler
autocmd VimEnter * colorscheme substrata

lua << END

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

 local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " },
  cond = hide_in_width,
}

local mode = {
  "mode",
  fmt = function(str)
    return "-- " .. string.upper(str) .. " --"
  end,
  color = function()
    return { bg = "#1c1c1c", fg = "#363636" }
  end,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "", -- git icon
  fmt = function(str)
    return str ~= "" and str or "unknown"  -- so element persists
  end,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local location = {
  "location",
  padding = 0,
}

local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }		-- stolen from some config
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local custom_theme = {
  normal = {
    a = { fg = "#b5b4c9", bg = "#242424", gui = "bold" },
    b = { fg = "#b5b4c9", bg = "#242424" },
    c = { fg = "#b5b4c9", bg = "#242424" },
  },
  insert = { a = { fg = "#b5b4c9", bg = "#242424", gui = "bold" } },
  visual = { a = { fg = "#b5b4c9", bg = "#242424", gui = "bold" } },
  replace = { a = { fg = "#b5b4c9", bg = "#242424", gui = "bold" } },
  inactive = {
    a = { fg = "#b5b4c9", bg = "#242424" },
    b = { fg = "#b5b4c9", bg = "#242424" },
    c = { fg = "#b5b4c9", bg = "#242424" },
  },
}

vim.defer_fn(function()

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = custom_theme,
    component_separators = "|",
    section_separators = "",
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diff }, 
    lualine_b = { mode },
    lualine_c = { "filename" },
    lualine_y = { location },
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_a = { branch, diff },
    lualine_b = { mode },
    lualine_c = { "filename" },
    lualine_y = { location },
    lualine_z = { progress },
  },
  tabline = {},
  extensions = {},
})
end, 10)

END

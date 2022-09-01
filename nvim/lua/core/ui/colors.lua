local M = {}

-- Theme: Rosé Pine (main)
-- Colors: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/palette.lua
-- color names are adapted to the formats above
M.rose_pine = {
  bg = '#111019', --default: #191724
  fg = '#e0def4',
  pink = '#eb6f92',
  green = '#9ccfd8',
  cyan = '#31748f',
  yellow = '#f6c177',
  orange = '#2a2837',
  red = '#ebbcba',
}

local monokai_schema_mapping = function(subtype)
  local monokai = require("monokai")
  return {
    bg = monokai[subtype].base1, --default: #211a22
    fg = monokai[subtype].white,
    pink = monokai[subtype].pink,
    green = monokai[subtype].green,
    cyan = monokai[subtype].aqua,
    yellow = monokai[subtype].yellow,
    orange = monokai[subtype].orange,
    red = monokai[subtype].orange,
  }
end

M.__index = function(_, key)
  if key == 'monokai_pro' then
    return monokai_schema_mapping("pro")
  elseif key == 'monokai' then
    local monokai = require('monokai')
    local palette = monokai.classic
    monokai.setup {
      palette = {
          diff_text = '#133337',
      },
      custom_hlgroups = {
          TSInclude = {
              fg = palette.aqua,
          },
          GitSignsAdd = {
              fg = palette.green,
              bg = palette.base2
          },
          GitSignsDelete = {
              fg = palette.pink,
              bg = palette.base2
          },
          GitSignsChange = {
              fg = palette.orange,
              bg = palette.base2
          },
      }
    }
    return monokai_schema_mapping("classic")
  elseif key == 'monokai_soda' then
    return monokai_schema_mapping("soda")
  elseif key == 'onedark' then
    return {
      bg = '#282c34',
      fg = '#b2bbcc',
      pink = '#c678dd',
      green = '#98c379',
      cyan = '#56b6c2',
      yellow = '#e5c07b',
      orange = '#d19a66',
      red = '#e86671',
    }
  else
    Log:error("No such color scheme")
  end
end

return setmetatable({}, M)

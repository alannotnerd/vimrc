lua << EOF
local palette = require('monokai').pro
palette.diff_text = '#133337'

require("monokai").setup({
  palette = palette,
  custom_hlgroups =  function(palette)
    return {
      NormalFloat = {
        fg = palette.white,
        bg = palette.base3,
      },
      PmenuSel = {
        bg = palette.base4,
      },
      TSInclude = {
        fg = palette.aqua,
      },
      GitSignsAdd = {
        fg = palette.green,
      },
      GitSignsDelete = {
        fg = palette.pink,
      },
      GitSignsChange = {
        fg = palette.orange,
      },
      CocSymbolField = {
        fg = palette.aqua
      }
    }
  end
})
EOF

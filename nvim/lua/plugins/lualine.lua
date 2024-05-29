return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local function h(name)
      local hl = vim.api.nvim_get_hl(0, { name = name })
      return {
        fg = hl.fg and string.format("#%x", hl.fg) or nil,
        bg = hl.bg and string.format("#%x", hl.bg) or nil,
      }
    end

    local colors = {
      blue = h("CmpItemKindVariable").fg,
      cyan = h("CmpItemKindMethod").fg,
      red = h("CmpItemKindStruct").fg,
      violet = h("CmpItemKindReference").fg,
      black = h("Normal").bg,
      white = h("Normal").fg,
      grey = h("Comment").fg,
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.red },
      },

      insert = { a = { fg = colors.black, bg = colors.blue } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },

      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white },
      },
    }
    return {
      options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
        lualine_b = { "branch" },
        lualine_c = opts.sections.lualine_c,
        lualine_x = opts.sections.lualine_x,
        lualine_y = opts.sections.lualine_y,
        lualine_z = opts.sections.lualine_z,
      },
      tabline = {},
      extensions = {},
    }
  end,
}

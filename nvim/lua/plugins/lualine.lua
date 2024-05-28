return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local icon = opts.sections.lualine_c[3]
    local file = opts.sections.lualine_c[4]
    local ctx = opts.sections.lualine_c[5]
    opts.sections.lualine_c[3] = nil
    opts.sections.lualine_c[4] = nil
    opts.sections.lualine_c[5] = nil

    opts.winbar = {
      lualine_b = { icon, file, ctx },
    }
  end,
}

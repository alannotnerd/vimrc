return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local groups = {
      "",
      "Copilot",
      "Field",
      "Property",
      "Event",
      "Text",
      "Enum",
      "Keyword",
      "Constant",
      "Constructor",
      "Reference",
      "Function",
      "Struct",
      "Class",
      "Module",
      "Operator",
      "Variable",
      "File",
      "Unit",
      "Snippet",
      "Folder",
      "Method",
      "Value",
      "EnumMember",
      "Interface",
      "Color",
      "TypeParameter",
    }

    for _, g in ipairs(groups) do
      local highlight = vim.api.nvim_get_hl(0, { name = "CmpItemKind" .. g })
      vim.api.nvim_set_hl(0, "CmpItemKind" .. g, { fg = "#FFFFFF", bg = highlight.fg })
    end

    opts.window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    }

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(_, item)
        local icons = require("lazyvim.config").icons.kinds
        item.menu = item.kind
        item.kind = " " .. (icons[item.kind] or " ") .. " "
        return item
      end,
    }
  end,
}

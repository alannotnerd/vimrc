return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    opts.view = {
      entries = { name = "custom", selection_order = "near_cursor" },
    }

    opts.window = {
      completion = {
        side_padding = 0,
      },
    }

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(_, item)
        local icons = require("lazyvim.config").icons.kinds
        item.menu = item.kind
        item.kind = "▌" .. (icons[item.kind] or " ") .. " "
        return item
      end,
    }
  end,
}

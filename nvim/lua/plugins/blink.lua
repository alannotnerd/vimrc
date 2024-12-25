return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        draw = {
          align_to_component = "kind_icon",
          padding = { 0, 1 },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
          components = {
            kind_icon = {
              text = function(ctx)
                return "▌" .. (ctx.kind_icon or " ")
              end,
            },
          },
        },
      },
    },
  },
}

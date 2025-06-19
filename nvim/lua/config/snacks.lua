return {
  "folke/snacks.nvim",
  config = function()
    require("snacks").setup({
      keymaps = {
        split_edit = { "s", "v" },
      },
    })
  end,
}

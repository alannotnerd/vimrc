require("core.bootstrap")

require("core.options").setup()
require("core.keymaps").setup()
require("core.plugin_loader").setup({
  "navarasu/onedark.nvim",
  "tanvirtin/monokai.nvim",
  { "rose-pine/neovim", as = "rose-pine" }
})
require("core.logger"):setup({ name = "aim", level = "DEBUG" })

require("core.explorer").setup()
require("core.ui").setup({
  colorscheme = "onedark"
})

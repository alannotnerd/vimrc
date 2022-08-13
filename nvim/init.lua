_G.config = {
  name = "avim",
  log = {
    level = "DEBUG",
    override_notity = true
  },
  use_icons = true
}

require("core/options")
require("core/autocmds")
require("core/keymaps")
require("core/colors")
require("core/boostrap")
require("core/ui")
require("core/lsp").setup()

require("plugins/nvim-cmp")
require("plugins/nvim-tree")
require("plugins/indent-blankline")
require("plugins/nvim-treesitter")
require("plugins/alpha-nvim")

require('plugins/telescope').setup()

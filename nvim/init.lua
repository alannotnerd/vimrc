config = {
  name = "avim",
  log = {
    level = "DEBUG",
    override_notity = true
  },
  use_icons = true
}

require("packer_init")

require("core/options")
require("core/autocmds")
require("core/keymaps")
require("core/colors")
require("core/statusline")
require("plugins/nvim-tree")
require("plugins/indent-blankline")
require("plugins/mason")
require("plugins/nvim-treesitter")
require("plugins/alpha-nvim")
require('plugins/telescope')

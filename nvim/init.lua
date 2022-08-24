_G.config = {
  name = "avim",
  log = {
    level = "DEBUG",
    override_notify = true,
  },
  use_icons = true,
  colorscheme = 'onedark'
}

require("core/boostrap")
require("core/options")
require("core/autocmds")
require("core/keymaps")
require("core/ui")
require("core/lsp").setup()
require("core.explorer").setup()

require("plugins/nvim-cmp")
require("plugins/indent-blankline")
require("plugins/nvim-treesitter")
require("plugins/alpha-nvim")

require("plugins/telescope").setup()

local ok, mod = pcall(require, "lsp-progress")
if ok then
  mod.setup()
end

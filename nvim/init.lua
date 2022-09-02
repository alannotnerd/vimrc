require("core.bootstrap")
require("core.options").setup()
require("core.keymaps").setup()
require("core.plugin_loader").setup({
  "navarasu/onedark.nvim",
  "tanvirtin/monokai.nvim",
  { "rose-pine/neovim", as = "rose-pine" },
  require('plugins.coc'),
  { 'frazrepo/vim-rainbow' },
  { 'tomtom/tcomment_vim' },
  { 'justinmk/vim-sneak' },
  { 'tpope/vim-surround' },
  { 'jiangmiao/auto-pairs' },
  {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
})
require("core.logger"):setup({ name = "aim", level = "DEBUG" })
require("core.ui").setup({
  colorscheme = "monokai"
})

require("core.explorer").setup()


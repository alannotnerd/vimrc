require("core.bootstrap")
require("core.options").setup()
require("core.keymaps").setup()
require("core.plugin_loader").setup({
  require('plugins.coc'),
  { 'frazrepo/vim-rainbow' },
  { 'tomtom/tcomment_vim' },
  { 'justinmk/vim-sneak' },
  { 'tpope/vim-surround' },
  require("plugins.nvim-autopair"),
  require("plugins.toggleterm"),
  require("plugins.nvim-colorizer")
})

vim.cmd[[colorscheme monokai]]

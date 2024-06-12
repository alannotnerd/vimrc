-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.swapfile = false
-- vim.o.clipboard = "unnamed"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    -- vim.highlight.on_yank()
    require("vim.ui.clipboard.osc52").copy("+")(vim.v.event.regcontents)
    require("vim.ui.clipboard.osc52").copy("*")(vim.v.event.regcontents)
  end,
})

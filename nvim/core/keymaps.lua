local M = {}

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts) ---@diagnostic disable-line
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options) ---@diagnostic disable-line
end

function M.setup()
  map("", "<up>", "<nop>")
  map("", "<down>", "<nop>")
  map("", "<left>", "<nop>")
  map("", "<right>", "<nop>")

  map("i", "jk", "<Esc>")

  map("n", "<F2>", ":set invpaste paste?<CR>")
  vim.opt.pastetoggle = "<F2>"

  map("n", "<leader>ar", ":so %<CR>")

  map("n", "<C-t>", ":Term<CR>") -- open
  map("t", "<Esc>", "<C-\\><C-n>") -- exit

  map("n", "<C-e>", ":NvimTreeToggle<CR>") -- open/close

  map("", "<C-j>", ":cn<CR>")
  map("", "<C-k>", ":cp<CR>")  
end

return M

local M = {}

function M.setup()
  local g = vim.g -- Global variables
  local opt = vim.opt -- Set options (global/buffer/windows-scoped)

  vim.cmd [[syntax off]]
  -- General
  opt.mouse = 'i' -- Enable mouse support
  opt.clipboard = 'unnamedplus' -- Copy/paste to system clipboard
  if vim.fn.executable("win32yank.exe") then
    g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
      cache_enabled = 0
    }
  end
  opt.swapfile = false -- Don't use swapfile
  opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options

  -- Neovim UI
  opt.number = true -- Show line number
  opt.showmatch = true -- Highlight matching parenthesis
  opt.foldmethod = 'marker' -- Enable folding (default 'foldmarker')
  opt.colorcolumn = '100' -- Line lenght marker at 80 columns
  opt.splitright = true -- Vertical split to the right
  opt.splitbelow = true -- Horizontal split to the bottom
  opt.ignorecase = true -- Ignore case letters when search
  opt.smartcase = true -- Ignore lowercase for the whole pattern
  opt.linebreak = true -- Wrap on word boundary
  opt.termguicolors = true -- Enable 24-bit RGB colors
  opt.laststatus = 3 -- Set global statusline
  opt.signcolumn = 'yes'

  -- Tabs, indent
  opt.expandtab = true -- Use spaces instead of tabs
  opt.shiftwidth = 2 -- Shift 4 spaces when tab
  opt.tabstop = 2 -- 1 tab == 4 spaces
  opt.smartindent = true -- Autoindent new lines

  -- Memory, CPU
  opt.hidden = true -- Enable background buffers
  opt.history = 100 -- Remember N lines in history
  opt.lazyredraw = true -- Faster scrolling
  opt.synmaxcol = 240 -- Max column for syntax highlight
  opt.updatetime = 700 -- ms to wait for trigger an event

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { numhl = sign.name })
  end

  -- Startup
  opt.shortmess:append "sI"

  local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
  }

  for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
  end
end

return M

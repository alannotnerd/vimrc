local M = {}

local telescope = require("telescope")
local builtin = require("telescope.builtin")

function M.setup_keymapping()
  local mappings = {
    ["<space>sf"] = builtin.find_files,
    ["<space>sg"] = builtin.live_grep,
    ["<space>sl"] = builtin.current_buffer_fuzzy_find,
    ["<space>s*"] = function()
      builtin.grep_string({ grep_open_files = true })
    end,
    ["<space>so"] = builtin.lsp_document_symbols,
    ["<space>s"] = builtin.builtin,
    ["<space>sa"] = builtin.diagnostics,
    ["gr"] = builtin.lsp_references,
    ["gd"] = builtin.lsp_definitions,

  }

  for key, action in pairs(mappings) do
    vim.keymap.set('n', key, action)
  end
end

function M.setup()
  M.setup_keymapping()
  telescope.setup({
  })
end

return M

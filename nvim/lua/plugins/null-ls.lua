local augroup = vim.api.nvim_create_augroup("LspFormat", {})
local logger = require('core.log'):get_logger()

local null_ls_config = function()
  local ok, null_ls = pcall(require, 'null-ls')
  if not ok then
    return
  end
	null_ls.setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.diagnostics.eslint,
			require("null-ls").builtins.completion.spell,
		},
	})
end

return null_ls_config

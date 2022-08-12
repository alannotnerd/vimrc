local augroup = vim.api.nvim_create_augroup("LspFormat", {})

local null_ls_config = function()
	require("null-ls").setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.diagnostics.eslint,
			require("null-ls").builtins.completion.spell,
		},
	})
end

return null_ls_config

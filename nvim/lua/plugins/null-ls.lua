local augroup = vim.api.nvim_create_augroup("LspFormat", {})

local null_ls_config = function()
	require("null-ls").setup({
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						local params = vim.lsp.util.make_formatting_params({})
						-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
						client.request("textDocument/formatting", params, nil, bufnr)
					end,
				})

				vim.keymap.set("n", "<space>f", function()
					local params = vim.lsp.util.make_formatting_params({})
					client.request("textDocument/formatting", params, nil, bufnr)
				end, { buffer = bufnr })
			end
		end,
		sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.diagnostics.eslint,
			require("null-ls").builtins.completion.spell,
		},
	})
end

return null_ls_config

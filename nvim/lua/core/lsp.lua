local M = {}

local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

local highlight_references = function (client )
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local make_capabilities = function () 
  local cmp_nvim_lsp = require('cmp_nvim_lsp')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
end

local on_attach = function(client)
  highlight_references(client)

  -- Diagnostic options, see: `:help vim.diagnostic.config`
  vim.diagnostic.config({
    update_in_insert = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- Show line diagnostics automatically in hover window
  vim.cmd([[
    autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
  ]])

  local keymapping = {
    gD = vim.lsp.buf.declaration,
    gd = vim.lsp.buf.definition,
    gr = vim.lsp.buf.references,
    K = vim.lsp.buf.hover,
    ['<C-k>'] = vim.lsp.buf.signature_help,
    ['<leader>rn'] = vim.lsp.buf.rename,
    ['<leader>ca'] = vim.lsp.buf.code_action,
  }

  for key, action in pairs(keymapping) do
    vim.keymap.set('n', key, action, { silent=true })
  end
end

local default_config = {
    on_attach = on_attach,
    capabilities = make_capabilities(),
    root_dir = root_dir,
    flags = {
      debounce_text_changes = 150
    }
}

local default_server_handler = function (server_name)
  Log:debug(server_name .. " attached")
  lspconfig[server_name].setup(default_config)
end

function M.setup()
  Log:debug("Setup lsp configure", { topic = 'LSP' })
  mason.setup()
  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers({
    default_server_handler,
    ['sumneko_lua'] = function ()
      Log:debug("sumneko_lua attached")
      local lua_dev = require('lua-dev').setup({
        lspconfig = default_config
      })
      lspconfig.sumneko_lua.setup(lua_dev)
    end
  })
end

return M 

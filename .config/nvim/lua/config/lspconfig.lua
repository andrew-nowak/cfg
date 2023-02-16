local nvim_lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
  -- format on save
  --if client.server_capabilities.documentFormattingProvider then
  --  vim.api.nvim_create_autocmd("BufWritePre", {
  --    group = vim.api.nvim_create_augroup("Format", { clear = true }),
  --    buffer = bufnr,
  --    callback = function() vim.lsp.buf.formatting_seq_sync() end
  --  })
  --end
  vim.diagnostic.config({
    virtual_text = false
  })
  vim.o.updatetime = 250
  vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
end

-- TypeScript
--TODO 
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

nvim_lsp.gopls.setup{}

nvim_lsp.rust_analyzer.setup{}

nvim_lsp.clangd.setup{}

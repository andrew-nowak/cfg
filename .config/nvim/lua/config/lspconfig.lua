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
vim.lsp.config('ts_ls', {
  on_attach = on_attach,
  root_dir = vim.fs.root("package.json"),
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  single_file_support = false
})
vim.lsp.enable('ts_ls')

vim.lsp.enable('gopls')

vim.lsp.enable('rust_analyzer')

vim.lsp.config('eslint', {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  root_dir = vim.fs.root("package.json"),
})
vim.lsp.enable('eslint')

vim.lsp.enable('svelte')

vim.lsp.config('hls', {
  filetypes = {'haskell', 'lhaskell', 'cabal' }
})
vim.lsp.enable('hls')



vim.cmd [[
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> L           <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>rf  <cmd>lua vim.lsp.buf.format { async = true }<CR>
nnoremap <silent> <leader>a  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
]]

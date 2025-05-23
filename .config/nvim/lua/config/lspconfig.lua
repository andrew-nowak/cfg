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
nvim_lsp.ts_ls.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  single_file_support = false
}

nvim_lsp.denols.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

nvim_lsp.gopls.setup{}

nvim_lsp.rust_analyzer.setup{}

nvim_lsp.clangd.setup{}

nvim_lsp.eslint.setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  root_dir = nvim_lsp.util.root_pattern("package.json"),
}

nvim_lsp.svelte.setup{}

nvim_lsp.hls.setup {
  filetypes = {'haskell', 'lhaskell', 'cabal' }
}

nvim_lsp.ocamllsp.setup{}


vim.cmd [[
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>rf  <cmd>lua vim.lsp.buf.format { async = true }<CR>
nnoremap <silent> <leader>a  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>diag   <cmd>lua require'metals'.open_all_diagnostics()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
]]

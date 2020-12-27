" autocmd BufWrite *.json lua vim.lsp.buf.formatting_sync(nil, 1000)
nnoremap <leader>json :%!python -m json.tool<CR>

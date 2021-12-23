setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufWrite *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
let python_highlight_all=1
setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=100 autoindent expandtab fileformat=unix tags=tags colorcolumn=95
hi ColorColumn ctermbg=166 guibg=125

setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufWrite *.h,*.hpp,*.cpp,*.c lua vim.lsp.buf.formatting_sync(nil, 1000)
setlocal equalprg=clang-format makeprg=make
autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=100 autoindent expandtab fileformat=unix tags=tags colorcolumn=95
hi ColorColumn ctermbg=166 guibg=125

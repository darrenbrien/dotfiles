setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufWrite *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
setlocal equalprg=clang-format
hi ColorColumn ctermbg=166 guibg=125
autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']

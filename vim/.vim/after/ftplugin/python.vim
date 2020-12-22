let python_highlight_all=1

setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=100 autoindent expandtab fileformat=unix tags=tags colorcolumn=90
nnoremap <buffer> <F9> :Black<cr>
inoremap <buffer> " ""<left>
inoremap <buffer> ' ''<left>
inoremap <buffer> ( ()<left>
inoremap <buffer> [ []<left>
inoremap <buffer> { {}<left>

hi ColorColumn ctermbg=166 guibg=125
match BadWhitespace /\s\+$/
match BadWhitespace /^\t\+/

au BufWritePre <buffer> execute ':Black'
let output = system('git rev-parse --show-toplevel')
if v:shell_error == 0
    au BufWritePost *.py silent! !ctags -R --python-kinds=-i &
endif

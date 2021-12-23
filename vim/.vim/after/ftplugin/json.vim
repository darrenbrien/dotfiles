function JsonFormat()
    let stdin = join(getline(1, '$'), "\n")
    let output = system('python -m json.tool', stdin)
    if v:shell_error == 0
        norm! ggdG 
        put =output
        norm! ggdd
    endif
endfunction
setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufWritePre <buffer> :execute JsonFormat() 
setlocal equalprg=python\ -m\ json.tool\ 2>/dev/null"

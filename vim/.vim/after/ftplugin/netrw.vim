let g:netrw_banner=0
let g:netrw_browse_split=2
let g:netrw_altv=1
let g:netrw_liststyle=3	
let g:netrw_winsize = 25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_browsex_viewer = "open"
au FileType netrw nnoremap <buffer> <leader>l :q<CR>
au FileType netrw nnoremap <buffer> <leader>h :q<CR>
au FileType netrw nnoremap <buffer> <leader>j :q<CR>
au FileType netrw nnoremap <buffer> <leader>k :q<CR>
au BufEnter :execute "HardTimeOff"

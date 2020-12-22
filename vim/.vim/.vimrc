set nocompatible
filetype off                  
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" ...
Plugin 'itchyny/lightline.vim'
Plugin 'neomake/neomake'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'takac/vim-hardtime'
Plugin 'psf/black', { 'tag': '19.10b0' }
Plugin 'morhetz/gruvbox'
Plugin 'alvan/vim-closetag'
Plugin 'vimwiki/vimwiki'
Plugin 'lilydjwg/colorizer'
Plugin 'bfrg/vim-cpp-modern'
if has('nvim')
    Plugin 'numirias/semshi'
    Plugin 'Shougo/deoplete.nvim'
    Plugin 'deoplete-plugins/deoplete-clang'
    Plugin 'deoplete-plugins/deoplete-jedi'
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
endif
call vundle#end()            
" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)
let g:neomake_python_pep8_exe = 'flake8'
let g:neomake_python_enabled_makers = ['pep8', 'flake8', 'pylama', 'pylint']
let g:neomake_python_pep8_exe = '/Users/darrenbrien/.pyenv/versions/3.7.7/envs/neovim3/bin/pycodestyle'
let g:neomake_python_flake8_exe = '/Users/darrenbrien/.pyenv/versions/3.7.7/envs/neovim3/bin/flake8'
let g:neomake_python_pylint_exe = '/Users/darrenbrien/.pyenv/versions/3.7.7/envs/neovim3/bin/pylint'
let g:neomake_python_pylama_exe = '/Users/darrenbrien/.pyenv/versions/3.7.7/envs/neovim3/bin/pylama'
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
   \ 'exe': 'clang++',
   \ 'args': ['-std=c++2a', '-Wall', '-Wextra', 'Wno-c++98-compat', '-Weverything', '-pedantic', '-Wno-sign-conversion'],
   \ }
let g:neomake_list_height = 8
let g:neomake_open_list = 0
let g:neomake_place_signs = 1

filetype plugin indent on     
syntax on
colorscheme gruvbox
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1
let g:hardtime_timeout = 500
"Turn on backup option Where to store backups Make backup before overwriting the current buffer Meaningful backup name, ex: filename@2015-04-05.14:59 Overwrite the original backup file
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=0 autoindent expandtab fileformat=unix 
set foldmethod=indent foldlevel=99 splitbelow splitright nu rnu nowrap encoding=utf-8 
set modeline background=dark ruler laststatus=2 hlsearch wildmenu cursorline cursorcolumn 
set ignorecase smartcase  
set backup backupdir=~/.vim/backup// writebackup backupcopy=yes
" need space end of line
set fillchars+=vert:\ 
set wildignore+=*.swp,*.ipynb,*.pyc
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }

hi BadWhitespace ctermfg=16 ctermbg=166 
match BadWhitespace /\s\+$/
match BadWhitespace /^\t\+/
hi MatchParen cterm=bold ctermbg=255 ctermfg=125
hi VertSplit cterm=None
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent pclose | endif
autocmd BufNewFile,BufRead *.md set filetype=markdown
let g:vimwiki_global_ext = 0

map <F2> :echo 'Current time is ' . strftime('%Y-%m-%d %X%Z')<CR>
map! <F3> <C-R>=strftime('%Y-%m-%d %X%Z')<CR>
" Enable folding with the f key
nnoremap <leader>f za
" turn off highlight on enter
nnoremap <CR> :nohlsearch<CR><CR>
nnoremap <leader>c :Commentary<cr>
nnoremap <leader>l <C-W>l
nnoremap <leader>k <C-W>k
nnoremap <leader>j <C-W>j
nnoremap <leader>h <C-W>h
nnoremap <leader>q <CR><C-W>q
nnoremap <leader>qq :w<CR><C-W>q
nnoremap <leader>v :sp<Space>~/.vimrc<CR>
nnoremap <leader>vv :so<Space>~/.vimrc<CR>
let output = system('git rev-parse --show-toplevel')
if v:shell_error == 0
    set path+=**
    set wildignore+=**/node_modules/**
    :execute "cd" . output
endif

" Some boss split maps
function ToggleSplitMaxHeight()
    if (winheight('%') > 25)
        :execute "resize " . 'wh'
    else
        :execute "resize" . 200
    endif
endfunction
function ToggleSplitMaxWidth()
    if (winwidth('%') > 120)
        :execute "vertical-resize" . 250
    else
        :execute "vertical-resize " . 'winminwidth'
    endif
endfunction
nnoremap <leader>= <C-W>=
nnoremap <leader>m :call ToggleSplitMaxHeight()<CR>
nnoremap <leader>n :call ToggleSplitMaxWidth()<CR>
nnoremap <leader><left> 7<C-W><
nnoremap <leader><up> 7<C-W>+
nnoremap <leader><right> 7<C-W>>
nnoremap <leader><down> 7<C-W>-
nnoremap <leader>tt :new term://zsh<CR>
nnoremap <leader>p :Vexplore<CR>
nnoremap <leader>/ :%s/
nnoremap <Space>w :w<CR>
nnoremap <Space>W :wa<CR>
nnoremap <Space>ht :HardTimeToggle<CR>
vnoremap <Space>ht :HardTimeToggle<CR>
nnoremap <Space>i :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap <Space>a :exec "normal a".nr2char(getchar())."\e"<CR>
nnoremap <Space>n :cnext<CR>
nnoremap <Space>p :cprev<CR>
nnoremap <Space>c :lclose<CR>
nnoremap <Space>o :lopen<CR>
inoremap <expr> <leader><leader> "<C-o>mp<C-o>A" . (nr2char(getchar())) . "<C-o>`p"
tnoremap <ESC> <C-\><C-n>
inoremap <leader><Space> <Esc>la
function JsonFormat(text)
    let output = system('python -m json.tool', a:text)
    if v:shell_error == 0
        return l:output
    else
        return a:text
    endif
endfunction

augroup my_neomake_qf
    autocmd!
    autocmd QuitPre * if &filetype != 'qf' | lclose | endif
augroup END

" Remove newbie crutches in Insert Mode
inoremap <Down> <Esc>:echo "No UDLR A <Start>!"<CR>i
inoremap <Left> <Esc>:echo "No UDLR A <Start>!"<CR>i
inoremap <Right> <Esc>:echo "No UDLR A <Start>!"<CR>i
inoremap <Up> <Esc>:echo "No UDLR A <Start>!"<CR>i

" Remove newbie crutches in Normal Mode
nnoremap <Down> :echo "No UDLR A <Start>!"<CR>
nnoremap <Left> :echo "No UDLR A <Start>!"<CR>
nnoremap <Right> :echo "No UDLR A <Start>!"<CR>
nnoremap <Up> :echo "No UDLR A <Start>!"<CR>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Esc>:echo "No UDLR A <Start>!"<CR>v
vnoremap <Left> <Esc>:echo "No UDLR A <Start>!"<CR>v
vnoremap <Right> <Esc>:echo "No UDLR A <Start>!"<CR>v
vnoremap <Up> <Esc>:echo "No UDLR A <Start>!"<CR>v

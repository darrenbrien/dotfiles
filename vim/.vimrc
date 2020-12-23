set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" ...
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'takac/vim-hardtime'
Plug 'lifepillar/gruvbox8'
Plug 'vimwiki/vimwiki'
Plug 'lilydjwg/colorizer'
Plug 'bfrg/vim-cpp-modern'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'szw/vim-maximizer'
" ...
call plug#end()

set cot=menuone,noinsert,noselect shm+=c
let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1

let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  nvim_lsp['clangd'].setup{
      on_attach = on_attach,
  }
  nvim_lsp['dockerls'].setup{
      on_attach = on_attach,
  }
  nvim_lsp['html'].setup{
      on_attach = on_attach,
  }
  nvim_lsp['jsonls'].setup{
      on_attach = on_attach,
  }
  nvim_lsp['pyls'].setup{
      cmd = {"/Users/darrenbrien/.pyenv/versions/neovim3/bin/pyls"},
      on_attach = on_attach,
  }
  nvim_lsp['vimls'].setup{
      on_attach = on_attach,
  }
  nvim_lsp['yamlls'].setup{
      on_attach = on_attach,
  }
EOF

set completeopt-=preview

colorscheme gruvbox8
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1
let g:hardtime_timeout = 500
"Turn on backup option Where to store backups Make backup before overwriting the current buffer Meaningful backup name, ex: filename@2015-04-05.14:59 Overwrite the original backup file
set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=0 autoindent expandtab fileformat=unix 
set foldmethod=indent foldlevel=99 splitbelow splitright nu rnu nowrap encoding=utf-8 
set modeline background=dark ruler laststatus=2 hlsearch wildmenu cursorline cursorcolumn 
set ignorecase smartcase  
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
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
nnoremap <leader>l <C-W>l
nnoremap <leader>k <C-W>k
nnoremap <leader>j <C-W>j
nnoremap <leader>h <C-W>h
nnoremap <leader>q <CR><C-W>q
nnoremap <leader>qq :w<CR><C-W>q
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>vv :so ~/.vimrc<CR>
let output = system('git rev-parse --show-toplevel')
if v:shell_error == 0
    set path+=**
    set wildignore+=**/node_modules/**
    :execute "cd" . output
endif

nnoremap <leader>= <C-W>=
nnoremap <leader><left> 7<C-W><
nnoremap <leader><up> 7<C-W>+
nnoremap <leader><right> 7<C-W>>
nnoremap <leader><down> 7<C-W>-
nnoremap <leader>m :MaximizerToggle<CR>
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

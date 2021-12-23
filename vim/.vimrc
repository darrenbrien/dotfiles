set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" ...
Plug 'bfrg/vim-cpp-modern'
Plug 'itchyny/lightline.vim'
Plug 'lifepillar/gruvbox8'
Plug 'lilydjwg/colorizer'
Plug 'szw/vim-maximizer'
Plug 'takac/vim-hardtime'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/indentpython.vim'
Plug 'vimwiki/vimwiki'
if has ('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
endif
" ...
call plug#end()

set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1
let g:completion_trigger_keyword_length = 2
let g:completion_enable_auto_popup = 1
let g:completion_timer_cycle = 500
let g:completion_matching_strategy_list = ['exact']
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1

if has('nvim')
:lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('completion').on_attach()
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
local servers = {'clangd', 'dockerls', 'jsonls', 'pyright', 'vimls', 'bashls'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
      }
    }
end
EOF
endif

set completeopt-=preview

colorscheme gruvbox8
let g:hardtime_default_on = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1
let g:hardtime_timeout = 500
"Turn on backup option Where to store backups Make backup before overwriting the current buffer Meaningful backup name, ex: filename@2015-04-05.14:59 Overwrite the original backup file
set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=0 autoindent expandtab fileformat=unix 
set updatetime=50
set foldmethod=indent foldlevel=99 splitbelow splitright nu rnu nowrap encoding=utf-8 
set modeline background=dark ruler laststatus=2 hlsearch wildmenu cursorline cursorcolumn 
set ignorecase smartcase  
set hidden incsearch
set scrolloff=1
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
set backup backupdir=~/.vim/backup// writebackup backupcopy=yes
" need space end of line
set fillchars+=vert:\ 
set wildignore+=*.swp,*.ipynb,*.pyc

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }
au BufEnter 127.0.0.1_lab*.txt set filetype=python guifont=:h16

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
nnoremap <leader>f za
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
    set wildignore+=**/.git/**
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
:nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
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
" tnoremap <ESC> <C-\><C-n>
inoremap <leader><Space> <Esc>la

" Using lua functions
nnoremap <leader>tf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>tg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>tb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>th <cmd>lua require('telescope.builtin').help_tags()<cr>

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

" NeoVim Configuration file of virtualanup
" https://virtualanup.com
"

filetype plugin indent on

" Hide toolbar and menubar in gvim
if has('nvim')
    " neovim based settings
else
    :set guioptions -=m
    :set guioptions -=T
endif

" python3 host program
let g:python3_host_prog = '/usr/bin/python3'

"Turn on syntax highlighting
syntax on

" Store a ton of history (default is 20)
set history=1000

" Allow buffer switching without saving
set hidden

" show file path in the title
set title
" '.' is an end of word designator
set iskeyword-=.

" '#' is an end of word designator
set iskeyword-=#

" '-' is an end of word designator
set iskeyword-=-

set tabstop=4
set number
set noswapfile

"remove menu bar
set guioptions-=m
  "remove toolbar
set guioptions-=T
"remove right-hand scroll bar
set guioptions-=r
"remove left-hand scroll bar
set guioptions-=L

" Dark background
set background=dark
" Automatically indent on new lines
set autoindent
" Copy the indentation of the previous line if auto indent doesn't know what to do
set copyindent
" Indenting a line with >> or << will indent or un-indent by 2
set shiftwidth=4
" Pressing tab in insert mode will use 4 spaces
set softtabstop=4
" Use spaces instead of tabs
set expandtab
set nowrap
" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces


" Puts new vsplit windows to the right of the current
set splitright

" Puts new split windows to the bottom of the current
set splitbelow

" pastetoggle (sane indentation on pastes)
set pastetoggle=<F12>

" Match, to be used with %
set matchpairs+=<:>

" PEP-8 Friendly
au FileType py set textwidth=79

set guifont=Monaco\ 9

" No extra spaces between rows
set linespace=0

" Backspace for dummies
set backspace=indent,eol,start

" Line numbers on
set nu

" Show matching brackets/parenthesis
set showmatch

" Find as you type search
set incsearch

" Highlight search terms
set hlsearch

" Windows can be 0 line high
set winminheight=0

" Case insensitive search
set ignorecase

" Case sensitive when uc present
set smartcase

" Show list instead of just completing
set wildmenu

" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full

" Backspace and cursor keys wrap too
set whichwrap=b,s,h,l,<,>,[,]

" Auto fold code
set foldenable

set list

" Only show 15 tabs
set tabpagemax=15

" Display the current mode
set showmode

" Minimum lines to keep above and below cursor
set scrolloff=1

" Autoinstall vim-plug {{{
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}


call plug#begin('~/.vim/plugged')

"Color schemes
Plug 'morhetz/gruvbox'

Plug 'sheerun/vim-polyglot'

" File management
Plug 'scrooloose/nerdtree'
" {{{
    map <C-e> :NERDTreeToggle<CR>
" }}}

Plug 'vim-scripts/sessionman.vim'
" {{{
    cabbrev so SessionOpen
    cabbrev ss SessionSave
" }}}


" fzf
" {{{
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " For opening files with fzf.
    map <C-p> :GFiles<CR>
    map <C-y> :Files<CR>
    let g:fzf_layout = { 'down': '~35%' }
" }}}

"Text management plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'rhysd/clever-f.vim'
" {{{
    let g:clever_f_across_no_line = 1
" }}}

Plug 'terryma/vim-multiple-cursors'
" {{{
    let g:multi_cursor_exit_from_visual_mode = 0
" }}}

Plug 'ntpeters/vim-better-whitespace'
" {{{
    " Remove trailing whitespace on save
    let g:better_whitespace_enabled=1
    let g:strip_whitespace_on_save=1
" }}}


Plug 'Yggdroot/indentLine'
" {{{
"
    let g:indentLine_color_tty_light = 7 " (default: 4)
    let g:indentLine_color_dark = 1 " (default: 2)
    let g:indentLine_char = '¦'

    let g:indentLine_color_term = 247
" }}}

Plug 'jiangmiao/auto-pairs'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction


" Programming Language plugins
Plug 'w0rp/ale'

" Vim clang format
Plug 'rhysd/vim-clang-format'

" {{{
let g:clang_format#code_style = "LLVM"
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false"
            \}
"autocmd FileType c,cpp ClangFormatAutoEnable
" }}}


Plug 'scrooloose/nerdcommenter'
Plug 'michaeljsmith/vim-indent-object'

" Visual
Plug 'lilydjwg/colorizer'

Plug 'itchyny/lightline.vim'
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Version control
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Misc
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-gtfo'
call plug#end()

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

autocmd BufEnter * silent! lcd %:p:h

" KEY REMAPPING
let mapleader = ','
" Remap ` to ' "
nnoremap ' `
nnoremap ` '

" Changing Esc to jk
imap jk <Esc>

" Easier moving from tabs and windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" workaround for ctrl-h not working inside tmux session
 if has('nvim')
     nmap <BS> <C-W>h
 endif


if has("cscope")
    """"""""""""" Standard cscope/vim boilerplate

    set tags=./tags,tags;$HOME
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose
endif

nnoremap Y y$

" leader and / to remove highlighting from the search term
nmap <silent> <leader>/ :nohlsearch<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
vnoremap . :normal .<CR>

cabbrev qq qa
cabbrev R !python3 %

set clipboard=unnamed
set clipboard+=unnamedplus

" Yank text to the clipboard
nnoremap <leader>y "+y
nnoremap <leader>yy "+Y

nnoremap <A-S-j> :m+<CR>==
nnoremap <A-S-k> :m-2<CR>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-S-j> <Esc>:m+<CR>==gi
inoremap <A-S-k> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc><<`]a
inoremap <A-l> <Esc>>>`]a
vnoremap <A-S-j> :m'>+<CR>gv=gv
vnoremap <A-S-k> :m-2<CR>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv

nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>


" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

"This allows for change paste motion cp{motion}
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
silent exe "normal! `[v`]\"_c"
silent exe "normal! p"
endfunction

nmap s <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


noremap <Leader>s :update<CR>
let g:gtfo#terminals = { 'unix' : 'urxvt' }

:vmap ,x :!tidy -q -i --show-errors 0<CR>
au FileType html setl sw=2 sts=2 et
au FileType htmldjango setl sw=2 sts=2 et
:command Thtml :%!tidy -q -i --show-errors 0
au FileType python setlocal formatprg=autopep8\ -
autocmd FileType python noremap <Leader>i gggqG
autocmd Filetype c,cpp noremap <Leader>i :ClangFormat<CR>
au BufNewFile,BufRead *.html set filetype=htmldjango
autocmd FileType htmldjango noremap <Leader>i gg=G

" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

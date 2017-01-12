" NeoVim Configuration file of virtualanup
" https://virtualanup.com
"

filetype plugin indent on

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

set guifont=Monaco\ 13
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
" Highlight problematic whitespace
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

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
Plug 'cschlueter/vim-wombat'
Plug 'scwood/vim-hybrid'
Plug 'morhetz/gruvbox'

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

Plug 'kien/ctrlp.vim'
" {{{
    let g:ctrlp_map = '<c-y>'
    let g:ctrlp_cmd = 'CtrlPBuffer'
    let g:ctrlp_working_path_mode = 'ra'
    nnoremap <c-p> :CtrlP <CR>

    if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif
" }}}


"Text management plugins
Plug 'tpope/vim-surround'

Plug 'rhysd/clever-f.vim'
" {{{
    let g:clever_f_across_no_line = 1
" }}}


Plug 'ntpeters/vim-better-whitespace'
" {{{
    " Remove trailing whitespace on save
    autocmd BufWritePre * StripWhitespace
" }}}


Plug 'Yggdroot/indentLine'
" {{{
    let g:indentLine_color_tty_light = 7 " (default: 4)
    let g:indentLine_color_dark = 1 " (default: 2)
    let g:indentLine_char = '¦'

    let g:indentLine_color_term = 247
" }}}

Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-expand-region'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
" {{{
    let g:deoplete#enable_at_startup = 1
" }}}

"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Programming Language plugins
Plug 'scrooloose/syntastic'
" {{{
  let g:syntastic_enable_signs          = 1
  let g:syntastic_enable_highlighting   = 1
  let g:syntastic_cpp_check_header      = 1
  let g:syntastic_enable_balloons       = 1
  let g:syntastic_echo_current_error    = 1
  let g:syntastic_check_on_wq           = 0
  let g:syntastic_error_symbol          = '✘'
  let g:syntastic_warning_symbol        = '!'
  let g:syntastic_style_error_symbol    = ':('
  let g:syntastic_style_warning_symbol  = ':('
  let g:syntastic_vim_checkers          = ['vint']
  let g:syntastic_elixir_checkers       = ['elixir']
  let g:syntastic_python_checkers       = ['flake8']
  let g:syntastic_javascript_checkers   = ['eslint']
  let g:syntastic_enable_elixir_checker = 0
" }}}

Plug 'scrooloose/nerdcommenter'
Plug 'michaeljsmith/vim-indent-object'

" Visual
Plug 'lilydjwg/colorizer'

Plug 'kshenoy/vim-signature'
" {{{
  let g:SignatureMarkerTextHL = 'Typedef'
  let g:SignatureMap = {
    \ 'Leader'             :  "m",
    \ 'PlaceNextMark'      :  "m,",
    \ 'ToggleMarkAtLine'   :  "m.",
    \ 'PurgeMarksAtLine'   :  "m-",
    \ 'DeleteMark'         :  "dm",
    \ 'PurgeMarks'         :  "m<Space>",
    \ 'PurgeMarkers'       :  "m<BS>",
    \ 'GotoNextLineAlpha'  :  "",
    \ 'GotoPrevLineAlpha'  :  "",
    \ 'GotoNextSpotAlpha'  :  "",
    \ 'GotoPrevSpotAlpha'  :  "",
    \ 'GotoNextLineByPos'  :  "]'",
    \ 'GotoPrevLineByPos'  :  "['",
    \ 'GotoNextSpotByPos'  :  "]`",
    \ 'GotoPrevSpotByPos'  :  "[`",
    \ 'GotoNextMarker'     :  "[+",
    \ 'GotoPrevMarker'     :  "[-",
    \ 'GotoNextMarkerAny'  :  "]=",
    \ 'GotoPrevMarkerAny'  :  "[=",
    \ 'ListLocalMarks'     :  "m/",
    \ 'ListLocalMarkers'   :  "m?"
    \ }
" }}}


Plug 'bling/vim-airline'
" {{{
let g:airline_left_sep  = '▓▒░'
let g:airline_right_sep = '░▒▓'
let g:airline_section_z = '%2p%% %2l/%L:%2v'
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_exclude_preview = 1

let g:airline_section_c = '%t'
" }}}


" Version control
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"Misc
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-gtfo'
Plug 'bling/vim-bufferline'
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



" Utilsnips settings
"inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

noremap <Leader>s :update<CR>

let g:gtfo#terminals = { 'unix' : 'urxvt' }

:vmap ,x :!tidy -q -i --show-errors 0<CR>
au FileType html setl sw=2 sts=2 et
au FileType htmldjango setl sw=2 sts=2 et
:command Thtml :%!tidy -q -i --show-errors 0
au FileType python setlocal formatprg=autopep8\ -
noremap <Leader>i gggqG
au BufNewFile,BufRead *.html set filetype=htmldjango

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

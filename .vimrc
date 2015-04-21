"           _
"    __   _(_)_ __ ___  _ __ ___
"    \ \ / / | '_ ` _ \| '__/ __|
"     \ V /| | | | | | | | | (__
"    (_)_/ |_|_| |_| |_|_|  \___|
"
set t_Co=256 " set 256 terminal colors

" Directories {{{

"set nowb
"set noswapfile

if has('win32')
  set backupdir=$HOME\vimfiles\bak
  set directory=$HOME\vimfiles\tmp
  set runtimepath+=$HOME\vimfiles
  set runtimepath+=$HOME\vimfiles\snippets
else
  set backupdir=$HOME/.vim/bak
  set directory=$HOME/.vim/tmp
  set runtimepath+=$HOME/.vim
  set runtimepath+=$HOME/.vim/snippets
endif
" }}}
" Search {{{
" set highlighted incremental searching with smart case ignoring
set hlsearch
set incsearch
set ignorecase
set smartcase
" }}}
" Tabs & Formatting {{{
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set formatoptions=tcqron2       " 'tc' wrap text and comments using textwidth
                                " 'q' allow formating of comments with gq
                                " 'ro' auto comment leader after <CR> or 'o'
                                " 'n' recognize numbered lists
                                " '2' use second line of paragraph for indent
                                " see :h fo-table
" }}}
" Misc {{{
" set wrap                        " wrap longer lines
set nowrap
set nocompatible                "
set nobackup                    " dont make backups before save
set exrc                        " enable per-directory .vimrc (BEWARE)
set history=700                 " how many lines of history VIM has to remember

set backspace=indent,eol,start  " standard backspace behaviour
set foldmethod=marker           " use markers for folding
set scrolloff=7                 " Minimal number of columns to scroll verticaly
set sidescroll=7                " and horizontally
set nolazyredraw                " redraw even when executing not typed commands
set fileformats=unix,dos        " EOL types autodetection
set ttyfast                     " fast terminal connection
set mouse=a                     " enable mouse in all modes
set confirm                     " ask what to do when leaving modified buffer
"set textwidth=80
" }}}
" UI {{{
syntax on
syntax sync maxlines=500
set wildmenu                    " command-line <Tab> completion above command line
set ruler                       " show where the cursor is
set showmatch                   " show matching bracets when text indicator is over them
set mat=2                       " how many tenths of a second to blink
set switchbuf=usetab            " also considers buffers in other tabs
set foldcolumn=2                " width of fold column
set showtabline=1               " show tabline only when there more than one tab page
set number                      " line numbering
set numberwidth=4               " width of number column
set linebreak                   " line break
" Look and Feel {{{
colorscheme myelflord           " modified elflord from 7.3
set showbreak==>
set cmdheight=1                 " commandline - 2 lines height
set laststatus=2                " show statusline - always

if has("gui_running")
  set vb t_vb=                  " hitting <ESC> in Normal Mode gives me headache
  set guitablabel=%t
  set showtabline=2             " always
  set guioptions=aci            " 'egmrLtT' is default
  set guifont=Terminus:h12:cEASTEUROPE
  if not has("gui_macvim")
    au GUIEnter * simalt ~x     " start maximized window (TODO)
  else
    set guifont=Droid Sans Mono:h14
  endif
endif
" }}}
" Status line {{{

" Git branch (not used)
function! GitBranch()
    let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    if branch != ''
        return '   Git Branch: ' . substitute(branch, '\n', '', 'g')
    en
    return ''
endfunction

set statusline=%n:%*\ %<%f\ %y%m%1*%r%*%=[%b,0x%B]\ \ %l/%L,%c%V\ \ %P
highlight StatusLine cterm=bold,underline ctermfg=7 ctermbg=5
highlight StatusLineNC cterm=underline ctermfg=7 ctermbg=0
" }}}
" }}}
" Keys {{{

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Ctrl+S Save buffer
"map  <C-S>  :w<CR>
"imap  <C-S>  <C-O>:w<CR>

" Ctrl+<F4> Close buffer
"map  <C-F4>  :q<CR>
"imap  <C-F4>  <C-O>:q<CR>


" <Ctrl><Tab>         - next/previous buffer
"       <Shift><Tab>
map <C-Tab> <Esc>:bn<CR>
map <S-C-Tab> <Esc>:bp<CR>

" <F4> Quickfix List
" TODO Toggle
map <F4> :botright cope<CR>
imap <F4> :botright cope<CR>

" <F5> save buffer & run make
imap <F5> <Esc>:Make<CR>
map <F5> :Make<CR>

" <F6> run make run
"imap <F6> <Esc>:w<CR>:!make run<CR>
"map <F6> :w<CR>:!make run<CR>

" <F12> Toogle pasting
set pastetoggle=<F12>


" Way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Tabs
map <leader>tc :tabnew<CR>
"map <leader>te :tabedit
map <leader>tx :tabclose<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>

" Search & Replace
map <leader>r :%s/<C-R><C-w>/
map <leader>R :grep -r <C-R><C-w>

" ,w Fast save
nmap <leader>w :w!<cr>

" buffer wipeout
nmap <C-x> :bw<CR>

" Quickfix
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" ,s for vimgrep current word in directory of the current buffer
if has('win32')
  map <leader>s :vimgrep <cword> %:p:h\\*.cpp %:p\\*.h<cr>
endif

nmap <leader>l :noh<cr>

nmap <leader>m :set foldmethod=syntax<cr>
nmap <leader>M :set foldmethod=marker<cr>

" command mode
cnoremap <C-A> <Home>

" ctags rebuild
"map <C-F12> :!ctags -R -f .ctags --language-force=c++ --fields=+iaS --extra=+q .<CR>
"set tags+=.ctags
" }}}

" Plugins

" Enable filetype
filetype indent on
filetype plugin on

" XML folding {{{
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
" }}}

" netrw {{{
let g:netrw_sort_sequence = '[\/]$' " sort directories first
" }}}

" fswitch {{{
au! BufEnter *.cpp,*.cxx,*.cc,*.c,*.mm let b:fswitchdst = 'h,hpp' | let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,ifrel:|/src/|../include|'
au! BufEnter *.h,*.hpp let b:fswitchdst = 'cpp,cc,c,mm' | let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,ifrel:|/include/|../src|'

nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>oh :FSLeft<cr>
nmap <silent> <Leader>oH :FSSplitLeft<cr>
nmap <silent> <Leader>ok :FSAbove<cr>
nmap <silent> <Leader>oK :FSSplitAbove<cr>
nmap <silent> <Leader>oj :FSBelow<cr>
nmap <silent> <Leader>oJ :FSSplitBelow<cr>

" }}}

" FuzzyFinder {{{
map <C-b> :FufBuffer<CR>
map <Bar> :FufLine<CR>
map <C-o> :FufFile<CR>
noremap <C-T> <C-O>
" }}}

" NERDTree {{{
let NERDTreeWinSize=30
let NERDTreeIgnore=['\.lo$','\.o$']
map <leader>g :NERDTreeFind<CR>
map <F2> :NERDTreeToggle<CR>
imap <F2> :NERDTreeToggle<CR>
" }}}

" tagbar-tagslist {{{
"if exists('loaded_taglist')
"  let Tlist_Show_One_File = 1
"  let Tlist_Use_Right_Window = 1
"  let Tlist_Auto_Open = 1
"  let Tlist_WinWidth = 40
"  let Tlist_Display_Prototype = 1
"  let Tlist_Compact_Format = 1
let g:tagbar_width = 40
let g:tagbar_sort = 0
map <F3> :TagbarToggle<CR>
imap <F3> :TagbarToggle<CR>
"endif
" }}}

" xptemplate {{{
" see ftplugin/_common/personal.xpt.vim for custom vars
let g:xptemplate_brace_complete = 0
"highlight link XPTcurrentPH Visual
"highlight link XPTfollowingPH Visual
" }}}

" clang-format {{{
" TODO windows version
map <C-K> :pyf ~/.vim/clang-format.py<CR>
imap <C-K> <ESC>:pyf ~/.vim/clang-format.py<CR>i
" }}}"

" vimcommander {{{
noremap <silent> <F10> :cal VimCommanderToggle()<CR>
" }}}

" nvim python support
let g:python_host_prog='/usr/bin/python'

" vundle

filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'gmarik/Vundle.vim'

Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-liquid'
Bundle 'tpope/vim-surround'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'drmingdrmer/xptemplate'
Bundle 'majutsushi/tagbar'
Bundle 'tikhomirov/vim-glsl'
Bundle 'feed57005/vim-cmakeproj'
Bundle 'vim-scripts/AnsiEsc.vim'
Bundle 'vim-scripts/vimcommander'
Bundle 'sukima/xmledit'
"Bundle 'juneedahamed/svnj.vim'

let g:airline_powerline_fonts=1
Bundle 'bling/vim-airline'

"let g:ycm_autoclose_preview_window_after_completion=1
"Bundle 'Valloric/YouCompleteMe'

"Bundle 'klen/python-mode'
"Bundle 'cstrahan/vim-capnp'
"Bundle 'gilligan/vim-lldb'

filetype plugin indent on

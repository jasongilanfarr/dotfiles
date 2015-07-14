" VIM only mode
set nocp
" don't use a swapfile or backup file
set noswapfile
set nobackup
" Indent tabstop when a tab is pressed
set smarttab
" 4 spaces to a tab
set tabstop=4
set shiftwidth=4
" auto-indent
set autoindent
" always expand tabs to spaces
set expandtab
" show matching brackets
set showmatch
" don't highlight search results
set nohlsearch
" turn off wrapping
set nowrap
" ignore case when searching
set ignorecase
" real backspace
set bs=2
" always show the status line
set laststatus=2
set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]
" Show the ruler
set ruler
" Spell check by default
set spell
" Highlight Trailing Whitespace
highlight ExtraWhitespace guibg=red
match ExtraWhitespace /\s\+$/
" And strip it on write
autocmd BufWritePre * :%s/\s\+$//e
" Show the command in the last line of the screen
set showcmd
" Save the file if it has been modified on certain conditions
" such as :make or a buffer change
set autowrite
" Make the mouse work as expected
set mouse=a
" Show the line number column with a width of 4
set number
set numberwidth=4
" Make copy-paste work like other apps
set clipboard+=unnamed
" Turn off the toolbar in the UI
set guioptions-=T
" Syntax Highlight by default
syntax on
" dark background
set bg=dark
" ignore build-style files when globbing.
set wildignore+=*.o,*.obj,.git,*.pyc,*.pdf,*.node,*.dep
" always expand tabs to spaces for python
au BufRead,BufNewFile *.py set expandtab
" change to the current directory
"autocmd BufEnter * silent! lcd %:p:h
set cursorline

" use Source Code Pro for UI Font
if has('gui_running')
set guifont=Source\ Code\ Pro:h11
else
endif

" don't set noexpandtab for makefiles
let _file = expand("%:t")
if _file =~ "Makefile" || _file =~ "makefile" || _file =~ ".*\.mk"
set noexpandtab
endif

"vundle
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

"let vundle manage vundle
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'TagHighlight'
Bundle 'kien/ctrlp.vim'
Bundle 'UltiSnips'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
"Bundle 'Rip-Rip/clang_complete'
Bundle 'Valloric/YouCompleteMe'
Bundle 'twerth/ir_black'
Bundle 'vim-scripts/blackboard.vim'
Bundle 'markcornick/vim-terraform'

filetype plugin indent on

let g:UltiSnipsExpandTrigger='<c-j>'
"set term=xterm-256color
set t_Co=256
set laststatus=2
let g:solarized_termcolors = &t_Co
let g:solarized_termtrans = 1
colors solarized

"let g:clang_use_library = 1
"let g:clang_complete_auto = 1
"let g:clang_hl_errors = 1
"let g:clang_snippets=1
"let g:clang_complete_macros=1
"let g:clang_complete_patterns=1
"let g:clang_periodic_quickfix=1
"let g:clang_snippets_engine="ultisnips"

set tags=./tags

if ! exists('g:TagHighlightSettings')
    let g:TagHighlightSettings = {}
endif

let g:TagHighlightSettings['TagFileName'] = 'tags'
let g:TagHighlightSettings['TypesFileDirectory'] = '/Users/jason/.tmp/'

let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_confirm_extra_conf=0

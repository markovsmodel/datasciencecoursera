filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

colorscheme jellybeans
"""" Display
if has("gui_running")
    " Remove menu bar
    set guioptions-=m
    " Remove toolbar
    set guioptions-=T
endif

"map alt-movement to window movement
map <M-j> <c-w>j
map <M-k> <c-w>k
map <M-l> <c-w>l
map <M-h> <c-w>h
" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>


map <leader>g :GundoToggle<CR>

set nocompatible              " Don't be compatible with vi
syntax on                           " syntax highlighing
filetype on                          " try to detect filetypes
filetype plugin indent on    " enable loading indent file for filetype
set relativenumber                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set grepprg=ack         " replace the default grep program with ack

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces 
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default

" don't outdent hashes
inoremap # #

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
"Fugitive also allows you to view what branch you are working in directly from vim. Add this to your statusline in ~/.vimrc:
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently 
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

" Paste from clipboard
map <leader>p "+p

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Select the item in the list with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

let g:pyflakes_use_quickfix = 0	"disable pyflakes quickfix window

let g:pep8_map='<leader>8'	"jump to each of the pep8 violations in the quickfix window

"Tab Completion and Documentation

"We've already enabled the SuperTab plugin in the bundle/ folder, 
"so we just have to configure it to be context sensitive and to 
"enable omni code completion in your ~/.vimrc
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

"enable the menu and pydoc preview to get the most useful information out of the code completion
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

"We also enabled the pydoc plugin at the beginning with all the submodules; that gives us the ability to hit <leader>pw when our cursor is on a module and have a new window open with the whole documentation page for it.

"Refactoring and Go to definition

"Ropevim is also a great tool that will allow you to navigate around your code. It supports automatically inserting import statements, goto definition, refactoring, and code completion. You'll really want to read up on everything it does, but the two big things I use it for is to jump to function or class definitions quickly and to rename things (including all their references).
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

"Searching

"You can fuzzy text search for anything in your code (variable name, class, method, etc) and it'll give you a list of files and line numbers where they are defined so you can quickly cycle through them. Just bind the searching to a key. 
"We use ! at the end of it so it doesn't open the first result automatically.
nmap <leader>a <Esc>:Ack!

"Integration with Git

"Git.vim will provide us syntax highlighting for git configuration files; fugitive provides a great interface for interacting with git including getting diffs, status updates, committing, and moving files.


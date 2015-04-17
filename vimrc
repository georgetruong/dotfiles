" Install Pathogen
call pathogen#infect()

" Use Vim settings, rather than Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
set nobackup
set history=500   " keep 500 lines of command line history
set ruler         " show the cursor position all the time
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set number        " set line numbers
set hidden
set autoindent
set showmatch
set nowrap
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set guifont=anonymous_pro:h11
set et
set sw=2
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2        " Always show status line.
set gdefault            " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent          " always set autoindenting on

set tabstop=4

set bg=dark
colorscheme distinguished
colors grb256

set backupdir=~/.tmp
set directory=~/.tmp    " Don't clutter my dirs up with swp and tmp files
set cursorline
set complete=.,t        " Only use current file and ctags for tab completion

set clipboard=unnamed

" Use Ack instead of grep
"set grepprg=ack

" Get rid of the delay when hitting esc!
set noesckeys

" Remove trailing whitespace on save for development files.
au BufWritePre *.rb :%s/\s\+$//e
au BufWritePre *.erb :%s/\s\+$//e
au BufWritePre *.js :%s/\s\+$//e
au BufWritePre *.coffee :%s/\s\+$//e
au BufWritePre *.feature :%s/\s\+$//e

" Treat handlebar files like HTML
au BufNewFile,BufRead *.handlebars set file type=html

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Open quickfix window after grep invocation
  autocmd QuickFixCmdPost *grep* cwindow

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" copy and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" NERDTree
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Enable filetype plugins NERDTree Commenter
filetype plugin on

" Only highlight in the current window
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Disable arrow keys for movement
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Unite.vim
  " File search
  nnoremap <C-p> :Unite file_rec/async<cr>         

  "Content search
  "nnoremap <space>/ :Unite grep:.<cr>

  "Yank history search
  let g:unite_source_history_yank_enable = 1
  nnoremap <space>y :Unite history/yank<cr>
  
  "Buffer search
  nnoremap <space>s :Unite -quick-match buffer<cr>

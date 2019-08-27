"""" Be VIM """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is not necessary with Neovim, but it still here incase this config ever needs to be loaded with vim
set nocompatible

"""" Load plugins with vim-plug """"""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.newvim/nvim/plugged')

" Color themes
Plug 'crusoexia/vim-monokai'

" Language support
Plug 'sheerun/vim-polyglot'

" Other
Plug 'mhinz/vim-signify' " Shows version control status in sign column
Plug 'itchyny/lightline.vim' " Awesome statusline
Plug 'moll/vim-bbye' " Well behaved :bdelete
Plug 'rhysd/clever-f.vim' " Better mappings for finding things
Plug 'roxma/nvim-yarp' " A remote plugin framework used by other plugins
Plug 'ncm2/ncm2' " Completion framework
Plug 'ncm2/ncm2-bufword' " Complete words in the current buffer
Plug 'ncm2/ncm2-path' " Complete paths from current buffer/cwd/root
Plug 'ncm2/ncm2-tmux' " Complete text from adjacent tmux panes
Plug 'filipekiss/ncm2-look.vim' " Complete words from the system dictionary
Plug 'ncm2/ncm2-ultisnips' " Complete from utilsnips
Plug 'SirVer/ultisnips' " Snippet framework
Plug 'honza/vim-snippets' " A library of preexisting snippits
Plug 'tomtom/tcomment_vim' " Handle comments
Plug 'tpope/vim-eunuch' " Unix command helper
Plug 'tpope/vim-repeat' " Allow . repeat to work with supported plugins
Plug 'tpope/vim-surround' " Easily manipulate surrounding things
Plug 'valloric/MatchTagAlways' " Highlight matching HTML/XML tags
Plug 'wellle/targets.vim' " Add more text objects
Plug 'luochen1990/rainbow' " Make the parens rainbow!
Plug 'christoomey/vim-tmux-navigator' " Easily navigate within tmux
Plug 'justinmk/vim-sneak' " Add a motion to quickly jump to text
Plug 'janko/vim-test' " Quickly and easily run unit tests
Plug 'benmills/vimux' " Easily run a command in a small tmux pane
Plug 'dense-analysis/ale' " Run linters
Plug 'liuchengxu/vim-which-key' " Interactive keybinding help
Plug 'tpope/vim-fugitive' " Git interface
Plug 'tpope/vim-rhubarb' " Github plugin for fugitive

call plug#end()

"""" Options """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No need to show the mode since lightline shows it in the statusbar
set noshowmode

" Turn on syntax and filetype detection
syntax on
filetype plugin indent on

" Show line numbers
set number
set relativenumber

" Setup tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab       " Use spaces instead of tabs
set smarttab        " Let's tab key insert 'tab stops', and bksp deletes tabs
set shiftround      " Tab/shifting moves to closest tabstop
set autoindent      " Match indents on new lines
set smartindent     " Auto indent when needed

" Autoreload changed files without asking
set autoread

" Sane backspace
set backspace=indent,eol,start

" Make search better
set ignorecase " Case insensitive search
set smartcase  " If there are uppercase letters, become case-sensitive
set incsearch  " Live incremental searching
set showmatch  " Live match highlighting
set hlsearch   " Highlight matches
set gdefault   " Use the `g` flag by default

" Allow hidden buffers without and error
set hidden

" Allow modelines
set modeline

" Use system clipboard by defautl
set clipboard=unnamedplus

" Show whitespace at the end of the line
set list listchars=trail:·

" Make the cursor stay in the center of the screen when possable
set scrolloff=9999

"""" Bindings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set Leader Key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

" Bind jk to esc to exit insert mode faster
inoremap jk <esc>
xnoremap jk <esc>

" Disable Arrow keys
map <Up> <NOP>
map <Down> <NOP>
map <Left> <NOP>
map <Right> <NOP>
imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>

" Disable escape key
imap <Esc> <NOP>

" Toggle between current and previously edited file
map <leader><tab> <C-^>

" ROT13 Madness
map <F5> ggg?G``

" Text operator for entire file
onoremap af :<C-u>normal! ggVG<CR>

" Make Y yank the rest of the line
noremap Y y$

" Stay in visual move after indenting
vnoremap < <gv
vnoremap > >gv

" Whichkey binding names
let g:which_key_map = {}
let g:which_key_map['e'] = {
      \ 'name': '+errors',
      \ 'n': ['ALENextWrap', 'Next error'],
      \ 'p': ['ALEPreviousWrap', 'Previous error'],
      \ 'd': ['ALEDetail', 'Detailed error'],
      \ 't': ['ALEToggle', 'Enable/Disable (toggle)'],
      \ 'b': ['ALEToggleBuffer', 'Enable/Disable for buffer (toggle)'],
      \ '=': ['ALEFix', 'Run fixer']
      \}

" Git operations
let g:which_key_map['g'] = {
      \ 'name': '+git',
      \ 'g': ['Gstatus', 'Git status window'],
      \ 'b': ['Gblame', 'Git blame'],
      \ 'o': ['Gbrowser', 'Open current file in browser']
      \}

call which_key#register('<Space>', "g:which_key_map")

""""" Plugin Configs """""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'ale_errors' ] ]
      \ },
      \ 'component': {
      \   'ale_errors': 'ALE: %#ALEErrorColor#%{CurrentBufferALEErrorsCount()}'
      \ }
      \ }

" Get the count of the ALE errors of the current buffer
function! CurrentBufferALEErrorsCount()
  let l:counts = ale#statusline#Count(bufnr(''))

  " Colors referenced from the lightline wombat theme directly
  let l:colors = {
        \'red': [
        \   g:lightline#colorscheme#wombat#palette.normal.error[0][3],
        \   g:lightline#colorscheme#wombat#palette.normal.error[0][1]
        \],
        \'green': [
        \   g:lightline#colorscheme#wombat#palette.insert.left[0][3],
        \   g:lightline#colorscheme#wombat#palette.insert.left[0][1],
        \],
        \'grey': [
        \   g:lightline#colorscheme#wombat#palette.visual.left[1][2],
        \   g:lightline#colorscheme#wombat#palette.visual.left[1][0],
        \]}
  let l:background = [
        \ g:lightline#colorscheme#wombat#palette.visual.left[1][3],
        \ g:lightline#colorscheme#wombat#palette.visual.left[1][1]
        \]

  if l:counts.total == 0
    let l:color = get(l:colors, 'green')
    let l:return_text = 'Ok'
  else
    let l:color = get(l:colors, 'red')
    let l:return_text = printf(
          \ '%d errors',
          \ l:counts.total
          \)
  endif

  " Display nothing if ALE hasn't linted this buffer
  if !get(b:, 'ale_linted', v:null)
    let l:color = get(l:colors, 'grey')
    let l:return_text = 'Not run'
  endif

  " Set the colors
  exe printf('highlight ALEErrorColor ctermfg=%d ctermbg=%d guifg=%s guibg=%s', color[0], l:background[0], color[1], l:background[1])

  return l:return_text
endfunction

"" ncm2
" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use c-j c-k for moving in snippet
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

"" Rainbow parens
let g:rainbow_active = 1 " Enable globally

"" Sneak
let g:sneak#s_next = 1

"" Test
let test#strategy = {
  \ 'nearest': 'vimux',
  \ 'file':    'basic',
  \ 'suite':   'basic',
  \}

"" ALE
" Set the fixers for some filetypes
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\}

" Run the fixers automatically on save
let g:ale_fix_on_save = 1

"" Which key
" Hide the statusline
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"""" Colorscheme """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme monokai

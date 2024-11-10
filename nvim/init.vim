set list
set ruler
set number
"set cursorline
"set cursorcolumn
syntax enable
set autoindent
set nocompatible
set title
set mouse=a               " Enable mouse in all modes (hold shift to disable)
set fillchars=eob:\ ,     " Replace end-of-buffer i.e. tilde with space
set tabstop=2             " The width of a TAB (\t) is set to 2
set shiftwidth=2          " Indents will have a width of 2
set softtabstop=2         " Sets the number of columns for TAB
set expandtab             " Expand TABs to spaces
set smarttab
set lazyredraw            " Improve scrolling performance when navigating through large results
set ignorecase smartcase  " Ignore case only when the pattern contains no capital letters
set secure exrc           " Project-specific settings
set nofoldenable          " Disable automatic folding
set clipboard=unnamed
set nobackup              " Some servers have issues with
set nowritebackup         " backup files, see #649 in CoC
set omnifunc=syntaxcomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType * setlocal foldmethod=syntax
filetype plugin indent on

" Use ctrl+hjkl to resize windows
nnoremap <C-j>    :resize -2<CR>
nnoremap <C-k>    :resize +2<CR>
nnoremap <C-h>    :vertical resize -2<CR>
nnoremap <C-l>    :vertical resize +2<CR>
" Use alt+hjkl to move between split/vsplit panels
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" Better tabbing
vnoremap < <gv
vnoremap > >gv
" Faster buffer navigation
map <silent> <F4> :bn<cr>
tnoremap <silent> <F4> <C-\><C-n>:bn<CR>
map <silent> <F3> :bp<cr>
tnoremap <silent> <F3> <C-\><C-n>:bp<CR>
" Swap functionality of ctrl-r and r
nnoremap r <C-r>
nnoremap <C-r> r
" Toggle line wrap
nnoremap <silent> <A-z> :set wrap!<CR>
" Change working directory
nnoremap <Leader>cd :cd %:p:h \| pwd<CR>

" Colorscheme configuration
if (has("termguicolors"))
 set termguicolors
endif
if has('win32') && split(systemlist('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme')[2])[2][2]
  let &background = 'light'
endif
" Toggle theme
function ThemeSetter()
  let &background = (&background == 'dark' ? 'light' : 'dark')
  highlight Comment cterm=italic gui=italic
  highlight Normal ctermbg=none guibg=none
  highlight SignColumn ctermbg=none guibg=none
  highlight LineNr ctermbg=none guibg=none
endfunction
nnoremap <Leader>ts :call ThemeSetter()<CR>

" Tags completion
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.js,*.html.erb,*.md'

" Save current file with elevated permissions
if has('win32')
  command W execute 'silent! write !gsudo busybox tee % >     nul ' <bar> edit!
else
  command W execute 'silent! write ! sudo         tee % >/dev/null' <bar> edit!
endif


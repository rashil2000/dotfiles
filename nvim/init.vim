set list
set ruler
set number
"set cursorline
"set cursorcolumn
syntax enable
set autoindent
set nocompatible
set mouse=a
set tabstop=2           " The width of a TAB is set to 2. Still it is a \t. It is just that Vim will interpret it to be having a width of 2.
set shiftwidth=2        " Indents will have a width of 2
set softtabstop=2       " Sets the number of columns for TAB
set expandtab           " Expand TABs to spaces
set smarttab
set clipboard=unnamed
set omnifunc=syntaxcomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete

call plug#begin('~/.vim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sheerun/vim-polyglot'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/rainbow_parentheses.vim'
  Plug 'junegunn/gv.vim'
  Plug 'ayu-theme/ayu-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'
  Plug 'mhinz/vim-startify'
  Plug 'jiangmiao/auto-pairs'
  Plug 'alvan/vim-closetag'
  Plug 'mileszs/ack.vim'
  Plug 'voldikss/vim-floaterm'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()


" Colorscheme configuration
if (has("termguicolors"))
 set termguicolors
endif
let ayucolor="light"
let g:airline_theme="ayu_light"
colorscheme ayu
highlight Comment cterm=italic gui=italic
highlight Normal ctermbg=none guibg=none
highlight SignColumn ctermbg=none guibg=none
highlight LineNr ctermbg=none guibg=none
" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Tags completion
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.js,*.html.erb,*.md'

" Nerd Commenter
filetype plugin indent on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

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
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
" Shift-Tab will cycle buffers
nnoremap <silent> <S-TAB> :bnext<CR>
" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Floaterm configuration
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_shell         = 'powershell -nol'
let g:floaterm_autoclose     = 1
let g:floaterm_wintype       = 'normal'
let g:floaterm_height        = 0.2
nnoremap <silent> <F10> :FloatermNew --wintype=floating --height=0.6<CR>
tnoremap <silent> <F10> <C-\><C-n>:FloatermNew --wintype=floating --height=0.6<CR>
nnoremap <silent> <C-f> :FloatermNew --wintype=floating --height=0.6 vifm<CR>
tnoremap <silent> <C-f> <C-\><C-n>:FloatermNew --wintype=floating --height=0.6 vifm<CR>

" Multi color Parentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['<', '>']]
autocmd FileType * RainbowParentheses

"" Startify configuration
let g:startify_session_dir = '~/AppData/Local/nvim/sessions'
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_lists = [
  \ { 'type': 'files',     'header': ['   Files']            },
  \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ ]
let g:startify_bookmarks = [
  \ { 'p': '~/Documents/WindowsPowershell/Microsoft.PowerShell_profile.ps1' },
  \ { 'i': '~/AppData/Local/nvim/init.vim' },
  \ 'D:/Data/Git',
  \ 'D:/Data/Projects',
  \ ]
let g:startify_custom_header = [
  \ '  /$$   /$$                     /$$    /$$ /$$                     /$$     /$$        ',
  \ ' | $$$ | $$                    | $$   | $$|__/                    |  $$   /$$/        ',
  \ ' | $$$$| $$  /$$$$$$   /$$$$$$ | $$   | $$ /$$ /$$$$$$/$$$$        \  $$ /$$//$$$$$$  ',
  \ ' | $$ $$ $$ /$$__  $$ /$$__  $$|  $$ / $$/| $$| $$_  $$_  $$        \  $$$$//$$__  $$ ',
  \ ' | $$  $$$$| $$$$$$$$| $$  \ $$ \  $$ $$/ | $$| $$ \ $$ \ $$         \  $$/| $$  \ $$ ',
  \ ' | $$\  $$$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$          | $$ | $$  | $$ ',
  \ ' | $$ \  $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$          | $$ |  $$$$$$/ ',
  \ ' |__/  \__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/          |__/  \______/  ',
  \]


"" Use ripgrep for searching with ack.vim ⚡️
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>


"" Custom configuration file for coc.nvim

" CoC-Explorer
augroup MyCocExplorer
  autocmd!
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * let d = expand('%') | if isdirectory(d) | bd | exe 'CocCommand explorer ' . d | endif
augroup END
" Automaticaly close nvim if Explorer is only thing left open
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
" Toggle
nnoremap <silent> <C-b> :CocCommand explorer<CR>

" List of completion extensions
let g:coc_global_extensions = ['coc-emmet', 'coc-highlight', 'coc-css', 'coc-explorer', 'coc-python', 'coc-sh', 'coc-vimlsp', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-powershell']

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
"set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
"set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

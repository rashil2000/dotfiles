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
set clipboard=unnamed
set omnifunc=syntaxcomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

call plug#begin(stdpath('data') . '/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'sheerun/vim-polyglot'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'rashil2000/ayu-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-startify'
  Plug 'jiangmiao/auto-pairs'
  Plug 'alvan/vim-closetag'
  Plug 'voldikss/vim-floaterm'
  Plug 'mg979/vim-visual-multi'
  Plug 'wfxr/minimap.vim'
call plug#end()


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
" Set/toggle theme
function ThemeSetter()
  if !exists("g:ayucolor")
    if !has('win32') || split(systemlist('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme')[2])[2][2]
      let g:ayucolor="light"
    else
      let g:ayucolor="dark"
    endif
  elseif g:ayucolor=="light"
    let g:ayucolor="dark"
  elseif g:ayucolor=="dark"
    let g:ayucolor="light"
  endif
  colorscheme ayu
  highlight Comment cterm=italic gui=italic
  highlight Normal ctermbg=none guibg=none
  highlight SignColumn ctermbg=none guibg=none
  highlight LineNr ctermbg=none guibg=none
endfunction
nnoremap <Leader>ts :call ThemeSetter()<CR>
call ThemeSetter()

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Goyo + Limelight configuration
let g:goyo_width = '70%'
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
nnoremap <silent> <Leader>gl :silent! Goyo<CR>

" Tags completion
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.js,*.html.erb,*.md'

" Minimap settings
nnoremap <silent> <Leader>mm :MinimapToggle<CR>
let g:minimap_git_colors = 1
let g:minimap_highlight_search = 1

" Visual Multi mappings
" Start marking using \\ (Leader) + \
nmap <C-LeftMouse>    <Plug>(VM-Mouse-Cursor)
nmap <C-RightMouse>   <Plug>(VM-Mouse-Word)
nmap <A-C-RightMouse> <Plug>(VM-Mouse-Column)

" Nerd Commenter
filetype plugin indent on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Floaterm configuration
let g:floaterm_keymap_new    = '<F9>'
let g:floaterm_keymap_prev   = '<F7>'
let g:floaterm_keymap_next   = '<F8>'
let g:floaterm_keymap_toggle = '<F12>'
let g:floaterm_shell         = 'pwsh'
let g:floaterm_autoclose     = 1
let g:floaterm_wintype       = 'split'
let g:floaterm_height        = 0.2
let g:floaterm_opener        = 'edit'
" Open a floating terminal
nnoremap <silent> <F10> :FloatermNew --wintype=floating --height=0.6<CR>
tnoremap <silent> <F10> <C-\><C-n>:FloatermNew --wintype=floating --height=0.6<CR>
" Pick folder/files using Vifm
nnoremap <silent> <C-y> :FloatermNew --wintype=floating --height=0.6 --title=Vifm\ Picker vifm<CR>
" Autocmd
function s:floatermSettings()
  setlocal nonumber norelativenumber  " Disable line numbers
  setlocal winblend=10                " Set transparency
endfunction
autocmd FileType floaterm call s:floatermSettings()


"" Startify configuration
let g:startify_session_dir = stdpath('data') . '/sessions'
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
function s:currdir()
  let workdir = getcwd()
  return [ { 'line': '<'.workdir.'>', 'path': workdir } ]
endfunction
let g:startify_skiplist = [ 'COMMIT_EDITMSG' ]
let g:startify_lists = [
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
  \ { 'type': function('s:currdir'), 'header': ['   Recents in current directory'], 'indices': ['d'] },
  \ { 'type': 'dir' },
  \]
let g:startify_bookmarks = [
  \ $MYVIMRC,
  \ '~/GitHub/rashil2000/dotfiles/Microsoft.PowerShell_profile.ps1',
  \ '~/GitHub',
  \ '~/Documents/Academics',
  \]
let g:startify_custom_header = startify#center([
  \ '  /$$   /$$                     /$$    /$$ /$$               ',
  \ ' | $$$ | $$                    | $$   | $$|__/               ',
  \ ' | $$$$| $$  /$$$$$$   /$$$$$$ | $$   | $$ /$$ /$$$$$$/$$$$  ',
  \ ' | $$ $$ $$ /$$__  $$ /$$__  $$|  $$ / $$/| $$| $$_  $$_  $$ ',
  \ ' | $$  $$$$| $$$$$$$$| $$  \ $$ \  $$ $$/ | $$| $$ \ $$ \ $$ ',
  \ ' | $$\  $$$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$ ',
  \ ' | $$ \  $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$ ',
  \ ' |__/  \__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/ ',
  \ '                                                             ',
  \])
let g:startify_custom_footer = startify#center([
  \ '                                                                      ',
  \ '                     .==::.                .::==.                     ',
  \ '                   .=***-:-++.  _-**-_  .++-:-***=.                   ',
  \ ' .+*=*-::::::::::::*+-/: *=*-/+=-:/\:-=+\-*=* :\-+*::::::::::::-*=*+. ',
  \ '  -===::::::::::::+\-:.*+-:*/--*+-ΦΦ-+*--\*:-+*.:-/+::::::::::::===-  ',
  \ '                  ·====- ..++.:==*\/*==:.++.. -====·                  ',
  \ '                            ˙-+ΨΨ%--%ΨΨ+-˙                            ',
  \ '                               \+*==*+/                               ',
  \ '                                 ˙::˙                                 ',
  \])



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
nnoremap <silent> <C-e> :CocCommand explorer<CR>

" List of completion extensions
let g:coc_global_extensions = [
  \ 'coc-lists',
  \ 'coc-git',
  \ 'coc-emmet',
  \ 'coc-highlight',
  \ 'coc-css',
  \ 'coc-explorer',
  \ 'coc-rls',
  \ 'coc-vimlsp',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-tsserver',
  \ 'coc-powershell'
  \]

" User configuration object
let g:coc_user_config = {
  \ "diagnostic.virtualText": v:true,
  \ "session.directory": stdpath('data') . '/sessions',
  \ "list.source.files.command": "fd",
  \ "list.source.files.args": [
  \   "--color", "never",
  \   "--type", "file",
  \   "--exclude", ".git",
  \   "--hidden",
  \   "--follow"
  \ ],
  \ "list.source.grep.args": [
  \   "--iglob", "!{.git}",
  \   "--hidden",
  \   "--follow"
  \ ],
  \
  \ "explorer.file.showHiddenFiles": v:true,
  \ "explorer.width": 30,
  \ "explorer.icon.enableNerdfont": v:true,
  \ "explorer.keyMappings": {
  \   "<cr>": [
  \     "expandable?",
  \     [
  \       "expanded?",
  \       "collapse",
  \       "expand"
  \     ],
  \     "open"
  \   ],
  \   "v": "open:vsplit"
  \ },
  \
  \ "powershell.integratedConsole.showOnStartup": v:false,
  \}

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

" Use K to show documentation in preview window (Use <C-ww> to move inside)
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
nnoremap <silent> <space>r  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Show most recently used files
nnoremap <silent> <space>m  :<C-u>CocList mru<cr>
" Show sessions
nnoremap <silent> <space>s  :<C-u>CocList sessions<cr>
" Show coc-lists
nnoremap <silent> <F2>      :<C-u>CocList<cr>
" Search inside files in current workspace
nnoremap <silent> <leader>/ :<C-u>CocList grep<CR>
" Search files in current workspace
nnoremap <silent> <C-p>     :<C-u>CocList files<CR>

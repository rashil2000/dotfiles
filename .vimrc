set number
set autoindent
set nocompatible
set laststatus=2
set t_Co=256
set t_u7=
set tabstop=4       
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
syntax enable
filetype off
filetype plugin on 
set omnifunc=syntaxcomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'scrooloose/syntastic'
    Plugin 'scrooloose/nerdtree' 
    Plugin 'mattn/emmet-vim'
    Plugin 'c.vim'
    Plugin 'valloric/matchtagalways'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'sirver/ultisnips'
    Plugin 'tpope/vim-fugitive'
    Plugin 'zxqfl/tabnine-vim'
call vundle#end()
filetype plugin indent on

" Trigger configuration for UltiSnips. Do not use <tab>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" NERDTree Key
map <F4> :NERDTreeToggle<CR>


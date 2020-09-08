set number
set autoindent



set nocompatible              " be iMproved, required
filetype off                  " required
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
 filetype plugin on 
 set omnifunc=syntaxcomplete#Complete
 autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'
 Plugin 'scrooloose/syntastic'
 Plugin 'Valloric/YouCompleteMe'
 "Plugin 'altercation/vim-colors-solarized'
 Plugin 'mattn/emmet-vim'
 Plugin 'c.vim'
 Plugin 'valloric/matchtagalways'
 Plugin 'octol/vim-cpp-enhanced-highlight'
 Plugin 'ap/vim-css-color'
 Plugin 'nathanaelkane/vim-indent-guides'
 Plugin 'sirver/ultisnips'
 Plugin 'tpope/vim-sensible'
 Plugin 'scrooloose/nerdtree' 
 Plugin 'tpope/vim-fugitive'
 Plugin 'pangloss/vim-javascript'
 " " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" " plugin from http://vim-scripts.org/vim/scripts.html
" " Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Install L9 and avoid a Naming conflict if you've already installed a
" " different version somewhere else.
" " Plugin 'ascenator/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
 call vundle#end()            " required
 filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
syntax enable
set background=dark
colorscheme peachpuff
"let g:solarized_termcolors=256
" Trigger configuration for UltiSnips. Do not use <tab>
 let g:UltiSnipsExpandTrigger="<tab>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Swap h and i and use IJKL for cursor movement
map i <Up>
map j <Left>
map k <Down>
noremap h i
map <F4> :NERDTreeToggle<CR>

" VIm Powerline
set rtp+=/home/rashil2000/.local/lib/python3.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256



set tabstop=4       
" The width of a TAB is set to 4. Still it is a \t. It is just that Vim will interpret it to be having a width of 4.
set shiftwidth=4
" Indents will have a width of 4		    
set softtabstop=4
" Sets the number of columns for TAB
set expandtab
" Expand TABs to spaces

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"source ~/.vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'ycm-core/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'preservim/nerdtree'
Plug 'glepnir/dashboard-nvim'
Plug 'mbbill/undotree'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-obsession'
Plug 'ryanoasis/vim-devicons'
Plug 'arcticicestudio/nord-vim'
"Plug 'b4skyx/serenade'
Plug 'semanser/vim-outdated-plugins'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'wfxr/minimap.vim'
"Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'
Plug 'tools-life/taskwiki'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'equalsraf/neovim-gui-shim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }


set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

call plug#end()

"let g:forest_night_enable_italic = 0
"let g:forest_night_disable_italic_comment = 1

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
syntax enable
set background=dark
"let g:forest_night_background = 'soft'
colorscheme nord
"hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE ctermfg=NONE
hi EndOfBuffer ctermbg=NONE
hi LineNr ctermbg=NONE
hi Folded ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

au BufNewFile,BufRead *.js, *.html, *.css
            \ set tabstop=2
            \ set softtabstop=2
            \ set shiftwidth=2

au FileType *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set nu

" air-line fonts
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ' ' "''
let g:airline_left_alt_sep = ' ' "''
let g:airline_right_sep = ' ' "''
let g:airline_right_alt_sep = ' ' "''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.dirty=' '

" Dashboard options
let g:dashboard_custom_header = [
            \ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
            \ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
            \ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
            \ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
            \ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
            \ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
            \]

let g:mapleader="\<Space>"
let g:dashboard_default_executive ='fzf'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fr :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>cc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fw :DashboardFindWord<CR>
nnoremap <silent> <Leader>jb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" setup for goyo & limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:goyo_width = 130
let g:goyo_height = 95
let b:code = "no"

"Toggle Goyo
map <C-g> :Goyo

"Enable/disable limelight when entering/leaving Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" setup for tagbar
nmap <t> :TagbarToggle<CR>

" enable mouse scroll
set mouse=a

" toggle number lines
:nnoremap <C-n> :set number!<CR>

" Nerdtree
"autocmd vimenter * NERDTree
map <C-d> :NERDTreeToggle<CR>

" Toggle Undotree
nnoremap <F5> :UndotreeToggle<CR>

" Clipboard shortcuts
:set clipboard=unnamedplus
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+P
imap <C-v> <C-r><C-o>+

" Yank whole line w/o newline
nmap Y ^y$

" airline theme
let g:airline_theme='nord'

"Indent line settings
set listchars=tab:\|\
set list

" Do not show any message if all plugins are up to date. 0 by default
let g:outdated_plugins_silent_mode = 1

" Set underline cursor
set guicursor=a:hor20-Cursor

" Needed for gnvim
set guifont=monospace:h11

" Minimap settings
let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" VimWiki use markdown
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
            \ 'path_html': '~/Documents/vimwiki_html',
            \ 'syntax': 'markdown', 'ext': '.md'}]
" Autoformat on save
au BufWrite * :Autoformat

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<grave>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

set cursorline
set cursorcolumn

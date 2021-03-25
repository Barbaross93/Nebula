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

Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'glepnir/dashboard-nvim'
Plug 'mbbill/undotree'

"Cool stuff

"Plug 'gabrielelana/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'heavenshell/vim-pydocstring'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-obsession'
"Plug 'dbeniamine/cheat.sh-vim'
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

set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'
"Plug 'edkolev/tmuxline.vim'

"R Plugins
"Plug 'jalvesaq/Nvim-R'
"Plug 'rizzatti/dash.vim'
"Plug 'chrisbra/csv.vim'
"Plug 'gaalcaras/ncm-R'
"Plug 'sirver/UltiSnips'
"Plug 'jimhester/lintr'


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
hi Normal guibg=NONE ctermbg=NONE
hi NonText ctermbg=NONE ctermfg=NONE 
hi EndOfBuffer ctermbg=NONE
hi LineNr ctermbg=NONE
hi Folded ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

au FileType *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set nu

" air-line fonts
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ' ' "''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ' ' "''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.dirty=' '


" Stop viminfo.tmp files (hopefully)
let skip_defaults_vim=1
"set viminfo=""

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
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" setup for goyo & limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:goyo_width = 130
let g:goyo_height = 95
let b:code = "no"

"Toggle Goyo and Limelight on and off
function! ToggleCoding()
    if exists("b:code") && b:code == "yes"
        let b:code = "no"
        Goyo!
        Limelight!
    else
        let b:code = "yes"
        Goyo
        Limelight
    endif
endfunction

"remove weird background change on exit
function s:goyo_enter()
    hi! VertSplit guibg=NONE
endfunction

function s:goyo_leave()
    hi Normal guibg=NONE ctermbg=NONE
    hi NonText ctermbg=none ctermfg=NONE
    hi EndOfBuffer ctermbg=none
    hi LineNr ctermbg=none
endfunction


autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" setup for tagbar
nmap <t> :TagbarToggle<CR>

" enable mouse scroll
set mouse=a

" toggle number lines
:nnoremap <C-n> :set number!<CR>

" Nerdtree
"autocmd vimenter * NERDTree
map <C-d> :NERDTreeToggle<CR>

" tmuxline changes
 let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '}

let g:tmuxline_preset = {
    \'a'    : '#S',
    \'b'    : ['', '#(whoami)'],
    \'win'  : ['#I #W'],
    \'cwin' : ['#I #W #F'],
    \'y'    : ['%a', '%m/%d/%y'],
    \'z'    : '#H'}

" Clipboard shortcuts
:set clipboard=unnamedplus
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+P
imap <C-v> <C-r><C-o>+

" Yank whole line w/o newline
nmap Y ^y$

" neomutt stuff
au BufRead /tmp/mutt-* set tw=72
au BufRead /tmp/mutt-* set wrap

" airline theme
let g:airline_theme='nord'

"Indent line settings
set listchars=tab:\|\ 
set list

" Do not show any message if all plugins are up to date. 0 by default
let g:outdated_plugins_silent_mode = 1

" Set underline cursor
set guicursor=a:hor20-Cursor

set cursorline
set cursorcolumn

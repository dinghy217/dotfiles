call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-sensible'
" Unsure I want to keep, seems niche for Xml/Html, adding removing parens is
" nice
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
Plug 'rust-lang/rust.vim'
" Unsure I'll use ,ig toggles indents- kinda ugly
Plug 'nathanaelkane/vim-indent-guides' 

call plug#end()


let mapleader = ","


" Configure NerdTree 
map <leader>nn :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Show command when typing command in bottom right
set showcmd

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Get Alacritty to use true colors, found on stackoverflow
if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" set colorscheme to dark-gruvbox by default
colorscheme gruvbox
set background=dark

" Ctrl+hjkl movement between panes
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Hybrid line numberings
set number relativenumber

" F8 to view tags for current buffer
nmap <F8> :TagbarToggle<CR>

" Make you save hidden buffers
set hidden


" Run :RustFmt to format code
" :RunTest runs test under cursor
let g:rustfmt_autosave = 1


" Map ,f to fuzzy file find
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>

" Get gitgutter to update signs faster, every 100ms
set updatetime=100

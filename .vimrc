call plug#begin('~/.vim/plugged')

" Everyone needs a file browser
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Don't forget to comment your code!
Plug 'tpope/vim-commentary'
" Source control is probably a good idea
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
" Don't question this one
Plug 'tpope/vim-sensible'
" Unsure I want to keep, seems niche for Xml/Html, adding removing parens is
" nice
Plug 'tpope/vim-surround'
" Dark/Light theme
Plug 'morhetz/gruvbox'
" Status bar
Plug 'vim-airline/vim-airline'
" Navigate by scope, code tags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
" Code search is #1
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Best organizational/notetaking tool
Plug 'vimwiki/vimwiki'
" Language syntax highlighting
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'nathangrigg/vim-beancount'
" Language server, requires post install configuration
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Startup menu
Plug 'mhinz/vim-startify'
" Debugger
Plug 'puremourning/vimspector'

call plug#end()

" Can't live without comma as leader key
let mapleader = ","

"
" NERDTree configuration
"
"" Show dotfiles in browser
let NERDTreeShowHidden=1

autocmd StdinReadPre * let s:std_in=1
"" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
"" Start NERDTree when Vim is started without file arguments.
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
"" Start NERDTree when Vim starts with a directory argument, focus on file browser
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd t | endif
"" Exit Vim if NERDTree is the only window remaining in the only tab. :q ftw
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"" simple shortcuts
map <leader>nn :NERDTreeMirror<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

"" Prettier menus
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"
" Debugger configuration
"
let g:vimspector_base_dir='/home/dinghy/.vim/plugged/vimspector'
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver


"
" Simple configurations
"
"" Ctrl+hjkl movement between panes for consistency
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
"" Show command when typing command in bottom right
set showcmd
"" Hybrid line numberings for faster normal mode
set number relativenumber
"" Make you save hidden buffers, enable switching off unsaved buffers
set hidden
"" I don't care for swapfiles for my workflow
set noswapfile
"" Ignore case when searching
set ignorecase
"" When searching try to be smart about cases 
set smartcase
"" Highlight search results
set hlsearch
"" Makes search act like search in modern browsers
set incsearch 
"" Don't redraw while executing macros (good performance config)
set lazyredraw 
"" Use spaces instead of tabs, Makefiles hate this one trick
set expandtab
"" Be smart when using tabs ;)
set smarttab
"" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
"" Linebreak on 500 characters
set lbr
set tw=500
"" Auto indent
set ai
"" Smart indent
set si
"" Wrap lines
set wrap
"" Disable highlight when <leader><cr> is pressed
""" AKA a search can be really annoying once you're done with it
map <silent> <leader><cr> :noh<cr>
"" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"" Toggle paste mode on and off
""" Some terminals copy/paste is less than stellar
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

set shell=/usr/bin/zsh

"
" Theme
"
"" set colorscheme to dark-gruvbox by default
colorscheme gruvbox
set background=dark

"" Get Alacritty to use true colors, found on stackoverflow
if exists('+termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

"" personal helpers to invoke script that switches terminal dark/light mode
function SetTerminalColor(profile)
	if a:profile =='dark'
		:!source theme-switch dark
		set background=dark
	else
		:!source theme-switch light
		set background=light
	endif
endfunction

"" Helper script interfaces via a simple env var on which mode should be active
if $THEME_CONTEXT == 'dark'
	set background=dark
else
	set background=light
endif

"" Convenience for switching terminal theme while in vim
nnoremap <silent> <leader>td :call SetTerminalColor("dark")<CR>
nnoremap <silent> <leader>tl :call SetTerminalColor("light")<CR>

"
" Codesearch config
"
"" Map ,f to fuzzy file find
nmap <leader>f :Files<CR>
nmap <leader>r :Rg<CR>
nmap <leader>F :GFiles<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>l :BLines<CR>
nmap <leader>L :Lines<CR>
nmap <leader>t :BTags<CR>
nmap <leader>T :Tags<CR>
nmap <leader>h :History<CR>
nmap <leader>a :Ag<CR>

"" F8 to view tags for current buffer
nmap <F8> :TagbarToggle<CR>

" Get gitgutter to update signs faster, every 100ms
set updatetime=100

"
" Language Server
"
"" Outright copied/pasted, 
"" TODO: I recognize there are conflicts with some settings in vimrc

""""""""""""""""
" Configure Coc
""""""""""""""""
" Install coc-rls for rust following: https://github.com/neoclide/coc-rls
" K to bring up docs, C-f/C-b to scroll docs
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [G :CocDiagnostics<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>gf  <Plug>(coc-format-selected)
nmap <leader>gf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}



"
" Startify Configuration
"
"" Include NerdTreeBookmarks, I rarely use bookmarks
let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")

" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
    let bookmarks = systemlist("cut -d' ' -f 2- ~/.NERDTreeBookmarks")
    let bookmarks = bookmarks[0:-2] " Slices an empty last line
    return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

"" returns all modified files of the current git repo
"" `2>/dev/null` makes the command fail quietly, so that when we are not
"" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

"" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \]

"" Enable startify and nerdtree together, and target startify pane
autocmd VimEnter * if !argc()
            \ |   wincmd w
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd p
            \ | endif

"
" Language Specific configuration
"
let g:python_highlight_all = 1
"" tip, run :RustFmt to format code on demand
let g:rustfmt_autosave = 1
"" JS/JSX can be very nested. 2 spaces is sensible
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

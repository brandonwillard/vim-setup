"set nocompatible

filetype off 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() 
  " let Vundle manage Vundle
  " required! 
  Plugin 'gmarik/Vundle.vim'
  Plugin 'The-NERD-Commenter'
  Plugin 'vimux'
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'tpope/vim-eunuch'
  Plugin 'syntastic'
  Plugin 'Lokaltog/vim-easymotion'
  "Plugin 'SirVer/ultisnips'
  "Plugin 'honza/vim-snippets'
  "Plugin 'Valloric/YouCompleteMe'
  Plugin 'Vim-R-plugin'
  Plugin 'bling/vim-airline'
  "Plugin 'tpope/vim-fugitive'
  Plugin 'LaTeX-Box'
  Plugin 'ShowMarks'
  "Plugin 'derekwyatt/vim-scala'
  "Plugin 'ivanov/vim-ipython'
  Plugin 'noweb.vim--McDermott'
  "Plugin 'julienr/vim-cellmode'
  "Plugin 'vim-pandoc/vim-pandoc'
  "Plugin 'vim-pandoc/vim-pandoc-syntax'
  "Plugin 'nathanaelkane/vim-indent-guides'
call vundle#end() 

filetype plugin indent on

set copyindent
set autoindent
set nostartofline
set wildmode=longest:full
set wildmenu
set hid
set ls=2
syntax enable
highlight comment ctermfg=blue
set ttyfast
set hls
set bg=dark
set t_Co=256 
color elflord 
set showmatch
set number
set foldmethod=syntax
"set foldnestmax=1tte
set nows
set backspace=indent,eol,start
syn spell toplevel
set spell spelllang=en_us

map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

set pastetoggle=<F2>
if has ('X11') && has ('gui')
    set clipboard=unnamedplus
endif

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-W>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-W>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-W>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-W>l :TmuxNavigateRight<cr>
nnoremap <silent> <C-W>\ :TmuxNavigatePrevious<cr>

"
" Status bar options
"
"set modeline
set showcmd
"set noshowmode
"set showmode
let g:airline#extensions#branch#enabled = 1
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
          

" Use Ctrl+Space to do omnicompletion:
"if has("gui_running")
"  "set term=$TERM
"  "set noguipty
"  inoremap <C-Space> <C-x><C-o>
"else
"  inoremap <Nul> <C-x><C-o>
"endif

" Omni/popup settings from here:
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
endif  

" don't select the first option that pops up.
set completeopt=longest,menuone

"" <Enter> selects a popup menu item
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" make <C-N/P> keep the highlighted selection when moving between menu items
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"" open omni completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"            \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
"" open user completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"            \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

"
" Completion settings
" 
let g:ycm_auto_trigger=0
let g:ycm_key_invoke_completion = '<c-space>'
let g:ycm_key_list_select_completion = ['<c-tab>', '<down>']
let g:ycm_key_list_select_previous_completion = ['<c-s-tab>', '<up>']
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


"set smartindent
"set cindent
set timeoutlen=600
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set diffopt+=iwhite

set mouse=a
set selectmode-=mouse
set mousefocus
set mousehide
set mousemodel=extend

"
" Fold-related stuff
"
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif


set scrolloff=8
set virtualedit=all
"set smarttab
"set iskeyword-=_
set cinkeys-=0#
set indentkeys-=0#
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>
map <F7> :syn sync fromstart<CR>
"set wrap
" Basic motions aren't affected by line wrapping...
noremap j gj
noremap k gk
noremap gj j
noremap gk k
"let &showbreak="\u21aa "

"set tags=tags;/

let marksCloseWhenSelected = 0
let showmarks_include = "abcdefghijklmnopqrstuvwxyz"

let g:clang_complete_auto=0
"let g:clang_use_library=1
"let g:clang_library_path=

"
" TeX and R-plugin settings
"
let g:tex_flavor='latex'

let vimrplugin_by_vim_instance=1
let vimrplugin_vimpager='vertical'
let vimrplugin_assign = 0
let vimrplugin_rnowebchunk = 0 
let vimrplugin_term='xterm'
let r_syntax_folding=0

let vimrplugin_applescript=0
"let vimrplugin_screenplugin=0

let g:vimrplugin_insert_mode_cmds=0
let g:vimrplugin_indent_commented=1
let g:r_indent_align_args=1



"
" eclim stuff
"
let g:EclimMakeLCD=1
let g:EclimDtdValidate=0
"set cot-=preview

let g:EclimProjectTreeActions = [
   \ {'pattern': '.*', 'name': 'Edit', 'action': 'edit'},
   \ {'pattern': '.*', 'name': 'Tab', 'action': 'tabnew'},
   \ {'pattern': '.*', 'name': 'Split', 'action': 'split'},
 \ ]
let g:EclimProjectTreeAutoOpen=1
let g:EclimProjectTreeSharedInstance=1
let g:EclimLocateFileDefaultAction='tab'
let g:EclimLocateFileScope='workspace'
let g:EclimLocateFileFuzzy=1
let g:EclimBuffersDefaultAction='tab'
let g:EclimDefaultFileOpenAction='tab'

" TODO put this somewhere more appropriate
command! JettyDebug call JettyDebugFn()
command! JDB call JDBFn()

" Default to tree mode
let g:netrw_liststyle=3

" Change directory to the current buffer when opening files.
" set autochdir

let g:netrw_list_hide= '.*\.swp$,.*\.swp\s,.*/$,.*/\s'

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

"
" Vimux settings
" could use this to get keywords: expand("<cword>")
" or this to get visual selection: getline("'<","'>")
" current line: getline(".")
"
function! VimuxSlime()
  " remove the trailing newline
  "call VimuxSendText(substitute(escape(@z,"`"),'\n*$','','g'))
  call VimuxSendText(escape(@z,"`"))
  call VimuxSendKeys("Enter")
endfunction

" send visual selection
vnoremap <LocalLeader>ts "zy :call VimuxSlime()<CR>  
" send line
nnoremap <LocalLeader>tl "zY :call VimuxSlime()<CR>  
" send word
nnoremap <LocalLeader>tp "zyiw :call VimuxSlime()<CR>  
" general run/open and quit/close
nnoremap <LocalLeader>tr :call VimuxOpenPane()<CR>  
nnoremap <LocalLeader>tq :VimuxCloseRunner<CR>


if filereadable(expand("./.vimrc.local"))
  source ./.vimrc.local
endif


function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

let noweb_backend="tex"
let noweb_language="python"
let noweb_fold_code = 0 

" helper for fixing syntax code:
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:pandoc#modules#disabled = ['chdir']
let g:pandoc#syntax#conceal#use = 0

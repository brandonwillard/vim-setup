set nocompatible

filetype off 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() 
  " let Vundle manage Vundle
  " required! 
  Plugin 'gmarik/Vundle.vim'
  Plugin 'The-NERD-Commenter'
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'tpope/vim-eunuch'
  Plugin 'syntastic'
  Plugin 'Lokaltog/vim-easymotion'
  "Plugin 'SirVer/ultisnips'
  "Plugin 'honza/vim-snippets'
  "Plugin 'Valloric/YouCompleteMe'
  if has('nvim')
    Plugin 'jalvesaq/Nvim-R'
    "Plugin 'bfredl/nvim-ipy'
    "Plugin 'kassio/neoterm'
  else
    Plugin 'vimux'
    Plugin 'jalvesaq/R-Vim-runtime'
    Plugin 'jcfaria/Vim-R-plugin'
  endif
  Plugin 'bling/vim-airline'
  Plugin 'tpope/vim-fugitive'
  "Plugin 'LaTeX-Box-Team/LaTeX-Box'
  Plugin 'lervag/vimtex'
  Plugin 'ShowMarks'
  "Plugin 'derekwyatt/vim-scala'
  "Plugin 'ivanov/vim-ipython'
  Plugin 'noweb.vim--McDermott'
  Plugin 'xolox/vim-easytags'
  Plugin 'xolox/vim-misc'
  "Plugin 'julienr/vim-cellmode'
  "Plugin 'vim-pandoc/vim-pandoc'
  "Plugin 'vim-pandoc/vim-pandoc-syntax'
  "Plugin 'nathanaelkane/vim-indent-guides'
  Plugin 'LargeFile'
  Plugin 'tpope/vim-surround'
  Plugin 'vshih/vim-make'
  "Plugin 'ktonga/vim-follow-my-lead'
call vundle#end() 

filetype plugin indent on

" in MB
let g:LargeFile=1024/2
set copyindent
set pi
set autoindent
set nostartofline
set wildmode=longest:full
set wildmenu
set hid
set ls=2
set ttyfast
set hls
set bg=dark
set t_Co=256 
color elflord 
syntax enable
highlight comment ctermfg=blue
set showmatch
set number
set foldmethod=syntax
"set foldnestmax=1tte
set nows
set backspace=indent,eol,start
"syn spell toplevel
syn spell default
"set spelllang=en_us
"set smartindent
"set cindent
set noto
"set timeoutlen=600
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
set scrolloff=8
set virtualedit=all
"set smarttab
set cinkeys-=0#
set indentkeys-=0#

" don't select the first option that pops up.
set completeopt=longest,menuone
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
let g:vimtex_fold_enabled = 0

if has("nvim")
  let g:rplugin_has_wmctrl = 1
  let R_pdfviewer = "qpdfview"
endif
" rmd/noweb chunk highlighting and folding
let rmd_syn_hl_chunk = 1
let noweb_fold_code = 1

" disable LatexBox mappings
let g:LatexBox_no_mappings = 1

set pastetoggle=<F2>
set clipboard+=unnamedplus
"if has('X11') && has('gui')
"    set clipboard+=unnamedplus
"endif

"set modeline
set showcmd
"set noshowmode
"set showmode

"
" look in ~/.vim/after/plugins, ~/.vim/after/syntax, ~/.vim/after/ftplugin
" for the plugin, syntax and filetype settings.
"
if filereadable(expand("./.vimrc.local"))
  source ./.vimrc.local
endif

function! GetVimCommandOutput(command) 
  " from: https://github.com/mbadran/headlights/blob/master/plugin/headlights.vim
  " capture and return the output of a vim command
  " initialise to a blank value in case the command throws a vim error
  " (try-catch doesn't always work here, for some reason)
  let l:output = ''

  redir => l:output
    execute "silent verbose " . a:command
  redir END

  return l:output
endfunction

function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

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
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" don't yank when replacing (could add <leader> to preserve original
" functionality).
vnoremap p "_dP

" These `n` & `N` mappings are optional. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)


" helper for debugging syntax code:
" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
"map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


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



"
" Check the folds below for settings.
" Otherwise, see the after/ ftplugins/ and other directories.
"
" -brandonwillard
"


" Important {{{
set nocompatible
filetype off 
" Vundle Config {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() 
  Plugin 'gmarik/Vundle.vim'
  Plugin 'The-NERD-Commenter'
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'tpope/vim-eunuch'
  Plugin 'syntastic'
  Plugin 'Lokaltog/vim-easymotion'
  Plugin 'qpkorr/vim-bufkill'
  Plugin 'hynek/vim-python-pep8-indent'
  Plugin 'hdima/python-syntax'
  Plugin 'davidhalter/jedi-vim'
  Plugin 'benekastah/neomake'
  Plugin 'Rykka/riv.vim'
  Plugin 'OnSyntaxChange'
  if has('nvim')
    Plugin 'jalvesaq/Nvim-R'
    " This, and other remote-plugins, requires :UpdateRemotePlugins 
    " after bundle installation.
    Plugin 'bfredl/nvim-ipy'
    "Plugin 'kassio/neoterm'
  else
    Plugin 'vimux'
    Plugin 'jalvesaq/R-Vim-runtime'
    Plugin 'jcfaria/Vim-R-plugin'
  endif
  Plugin 'bling/vim-airline'
  Plugin 'tpope/vim-fugitive'
  Plugin 'lervag/vimtex'
  Plugin 'ShowMarks'
  Plugin 'noweb.vim--McDermott'
  Plugin 'xolox/vim-easytags'
  Plugin 'xolox/vim-misc'
  Plugin 'LargeFile'
  Plugin 'tpope/vim-surround'
  "Plugin 'ktonga/vim-follow-my-lead'
  Plugin 'altercation/vim-colors-solarized'
call vundle#end() 

" run my 'after' code last
set rtp+=~/.vim/after
" }}}
filetype plugin indent on

set pastetoggle=<F2>
" }}}

" Tabs and Indenting {{{
set copyindent
set pi
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
"set smartindent
"set cindent
"set smarttab
set cinkeys-=0#
set indentkeys-=0#

" }}}

" Command Line Editing {{{
set wildmode=longest:full
set wildmenu
" }}}

" Reading and Writing Files {{{
let g:LargeFile=1024/2 " in MB
set modeline
set modelines=1
" }}}

" Moving Around, Searching and Patterns {{{
set nostartofline
set nows
" }}}

" Multiple Windows {{{
set hid
set ls=2
set switchbuf=useopen
" }}}

" Syntax, Highligting and Spelling {{{
set hls
syntax enable
highlight comment ctermfg=blue
"syn spell toplevel
syn spell default
"set spelllang=en_us
" }}}

" Terminal {{{
set ttyfast
" }}}

" Mapping {{{
let mapleader='\'
let maplocalleader=','
set noto
"set timeoutlen=600
if has("nvim")
  " allow us to easily use window motions in a terminal
  tnoremap <c-w> <c-\><c-n><c-w>
  " leave insert mode in terminal with ESC
  tnoremap <Esc> <C-\><C-N>
endif

" Use Ctrl+Space to do omnicompletion:
"if has("gui_running")
"  "set term=$TERM
"  "set noguipty
"  inoremap <C-Space> <C-x><C-o>
"else
"  inoremap <Nul> <C-x><C-o>
"endif

" from: https://github.com/justinmk/config/blob/7b97ae50b5377b35d37128fe1225c47e5fcba7d0/.vimrc#L1021
" disable Ex mode key 
noremap Q <Nop>

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
" don't yank when replacing (could add <leader> to preserve original
" functionality).
vnoremap p "_dP

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

" }}}

" Appearance {{{
"set t_Co=256 
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dmu
"colorscheme elflord 
"colorscheme solarized
colorscheme torte
let g:solarized_termcolors=256
set background=dark
" }}}

" Python {{{
" might help when your env is virtual or whatnot
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'
let g:pymode_indent = 0
" }}}

" Editing Text {{{
set showmatch
set backspace=indent,eol,start
set completeopt=longest,menuone
" }}}

" Displaying Text {{{
set number
set scrolloff=8
" disable tex code->character conversion
set conceallevel=0
" }}}

" Folding {{{
set foldmethod=syntax
"set foldnestmax=1tte
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
" }}}

" Diff Mode {{{
set diffopt+=iwhite
" }}}

" Using the mouse {{{
set mouse=a
set mousefocus
set mousehide
set mousemodel=extend
" }}}

" Selecting Text {{{
set selectmode-=mouse
set clipboard+=unnamedplus
"if has('X11') && has('gui')
"    set clipboard+=unnamedplus
"endif
" }}}

" Various {{{
set virtualedit=all
"
" look in ~/.vim/after/plugins, ~/.vim/after/syntax, ~/.vim/after/ftplugin
" for the plugin, syntax and filetype settings.
"
if filereadable(expand("./.vimrc.local"))
  source ./.vimrc.local
endif
" }}}

" Messages and Info {{{
set showcmd
"set noshowmode
"set showmode
" }}}

" Functions {{{
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

" Capture output of Ex commands
" from: http://vim.wikia.com/wiki/Capture_ex_command_output
" this function output the result of the Ex command into a split scratch
" buffer
function! OutputSplitWindow(...)
  let cmd = join(a:000, ' ')
  let temp_reg = @"
  redir @"
  silent! execute cmd
  redir END
  let output = copy(@")
  let @" = temp_reg
  if empty(output)
    echoerr "no output"
  else
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
    put! =output
    setl nomodifiable 
  endif
endfunction
command! -nargs=+ -complete=command Output call OutputSplitWindow(<f-args>)

"function! TabMessage(cmd)
"  redir => message
"  silent execute a:cmd
"  redir END
"  tabnew
"  silent put=message
"  set nomodified
"endfunction
"command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
" }}}

" Autocommands {{{
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Omni/popup settings from here:
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
endif  
" }}}


"
" [Generally] global plugin settings from here on.
"

" R-plugin {{{
" don't select the first option that pops up.
let R_user_maps_only = 1   
let R_insert_mode_cmds = 0 
let R_assign = 0

let R_pdfviewer = "qpdfview"
let g:rplugin_has_wmctrl = 1
let rmd_syn_hl_chunk = 1

let vimrplugin_source_args = "local = TRUE"
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


" }}}

" Noweb {{{
" rmd/noweb chunk highlighting and folding
let noweb_fold_code = 1
" }}}

" Latex {{{
" disable LatexBox mappings
let g:LatexBox_no_mappings = 1
let g:tex_fold_enabled=1
let g:vimtex_fold_enabled = 0
" }}}

" NERDCommenter {{{
let g:NERDAllowAnyVisualDelims=1
let g:NERDCommentWholeLinesInVMode=1
let g:NERDRemoveAltComs=1
let g:NERDRemoveExtraSpaces=1
let g:NERDDefaultNesting=1
" }}}

" Jedi {{{
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = "2"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-N>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#auto_vim_configuration = 0
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}

" Airline {{{
let g:airline#extensions#branch#enabled = 1
"let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1 
" }}}

" Eclim {{{
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

" }}}

" NetrwPlugin {{{
"
" netrw settings
"
" Default to tree mode
let g:netrw_liststyle=3

" Change directory to the current buffer when opening files.
" set autochdir

let g:netrw_list_hide= '.*\.swp$,.*\.swp\s,.*/$,.*/\s'

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" }}}

" nvim-ipy {{{
"let g:nvim_ipy_perform_mappings = 0
"map <silent> <Leader>tr :IPython <cr>
"map <silent> <Leader>ts <Plug>(IPy-Run)
"map <silent> <Leader>tk <Plug>(IPy-Terminate)
"map <silent> <Leader>tq <Plug>(IPy-Interrupt)
"map <silent> <Leader>tp <Plug>(IPy-WordObjInfo)
" }}}

" pandoc {{{
let g:pandoc#modules#disabled = ['chdir']
let g:pandoc#syntax#conceal#use = 0
" }}}

" showmarks {{{
let marksCloseWhenSelected = 0
let showmarks_include = "abcdefghijklmnopqrstuvwxyz"

" }}}

" tmux_navigator {{{
let g:tmux_navigator_no_mappings = 1
if !has("nvim")
  silent! nunmap <C-h>
  silent! nunmap <C-j>
  silent! nunmap <C-k>
  silent! nunmap <C-l>

  nnoremap <silent> <C-W>h :TmuxNavigateLeft<cr>
  nnoremap <silent> <C-W>j :TmuxNavigateDown<cr>
  nnoremap <silent> <C-W>k :TmuxNavigateUp<cr>
  nnoremap <silent> <C-W>l :TmuxNavigateRight<cr>
  nnoremap <silent> <C-W>\ :TmuxNavigatePrevious<cr>
endif
" }}}

" vimux {{{

"let scriptnames = GetVimCommandOutput("scriptnames")
"if match(scriptnames, "/".expand("%:t")) < 0
"  finish
"endif

" Vimux settings
" could use this to get keywords: expand("<cword>")
" or this to get visual selection: getline("'<","'>")
" current line: getline(".")
"
if !has("nvim")

  function! VimuxSlime()
    call VimuxSendText(escape(@z,'`\'))
    call VimuxSendKeys("Enter")
  endfunction

  function! VimuxBufferStart()
    if exists("g:vimux_run_command")
      call VimuxRunCommand(g:vimux_run_command)
    else
      call VimuxOpenPane()
    endif
  endfunction

  " send visual selection
  if empty(mapcheck("<LocalLeader>ts"))
    vmap <LocalLeader>ts "zy :call VimuxSlime()<CR>  
  endif

  " send line
  if empty(mapcheck("<LocalLeader>tl"))
    map <LocalLeader>tl "zY :call VimuxSlime()<CR>  
  endif

  " send/print word
  if empty(mapcheck("<LocalLeader>tp"))
    nmap <LocalLeader>tp "zyiw :call VimuxSlime()<CR>  
  endif

  " general run/open and quit/close
  if empty(mapcheck("<LocalLeader>tr"))
    nnoremap <LocalLeader>tr :call VimuxBufferStart()<CR>  
  endif

  if empty(mapcheck("<LocalLeader>tq"))
    nnoremap <LocalLeader>tq :VimuxCloseRunner<CR>
  endif
endif
 
" }}}

" youcompleteme {{{
let g:ycm_auto_trigger=0
let g:ycm_key_invoke_completion = '<c-space>'
let g:ycm_key_list_select_completion = ['<c-tab>', '<down>']
let g:ycm_key_list_select_previous_completion = ['<c-s-tab>', '<up>']
" }}}

" easymotion {{{
" These `n` & `N` mappings are optional. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" }}}

" riv {{{
let g:riv_python_rst_hl=1
" }}}

" vim:foldmethod=marker:foldlevel=0

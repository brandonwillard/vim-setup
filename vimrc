"
" Check the folds below for settings.
" Otherwise, see the after/ ftplugins/ and other directories.
"
" -brandonwillard
"


" Important {{{

" Plugins Config {{{
call plug#begin('~/.vim/bundle/') 

  " remote-plugins require `:UpdateRemotePlugins`
  " after bundle installation.
  " Wrap this in `has('nvim')`?
  function! DoRemote(arg)
    echom "updating remote plugins"
    UpdateRemotePlugins
  endfunction

  " Syntax, Markdown
  Plug 'SirVer/ultisnips', {'do': function('DoRemote')} 
  Plug 'honza/vim-snippets'
  "Plug 'valloric/YouCompleteMe'
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}
  else
    " TODO: add neocomplete
  endif
  Plug 'scrooloose/syntastic'
  Plug 'The-NERD-Commenter'
  "Plug 'Rykka/riv.vim', { 'for': ['python', 'rst']}

  " Motion, Buffers, Windows
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'qpkorr/vim-bufkill'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'sgur/vim-textobj-parameter'
  Plug 'tpope/vim-surround'

  " Python
  Plug 'bps/vim-textobj-python'
  Plug 'klen/python-mode'
  "Plug 'jmcantrell/vim-virtualenv'
  "Plug 'tell-k/vim-autopep8'
  "Plug 'jimf/vim-pep8-text-width'
  "Plug 'hynek/vim-python-pep8-indent'
  "Plug 'hdima/python-syntax'
  "Plug 'ivanov/vim-ipython', { 'for': '*python*'} 
  if has('nvim')
    Plug 'zchee/deoplete-jedi', { 'for': '*python*'} 
    "Plug 'bfredl/nvim-ipy', {'do': function('DoRemote'), 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-ipy', {'do': function('DoRemote'), 'for': '*python*'} 
    Plug '~/.vim/dev/nvim-jupyter', {'do': function('DoRemote'), 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-example-python-plugin', {'do': function('DoRemote')} 
  else
      "Plug 'davidhalter/jedi-vim'
  endif

  " R
  if has('nvim')
    Plug 'jalvesaq/Nvim-R', { 'for': ['r', 'rnoweb', 'rmd']} 
  else
    Plug 'jalvesaq/R-Vim-runtime', { 'for': ['r', 'rnoweb', 'rmd']}
    Plug 'jcfaria/Vim-R-plugin', { 'for': ['r', 'rnoweb', 'rmd']}
  endif

  " Terminal/REPL
  if has('nvim')
    "Plug 'kassio/neoterm'
  else
    Plug 'vimux'
  endif

  " Filesystem, Make, Git 
  Plug 'benekastah/neomake'
  Plug 'tpope/vim-fugitive'
  Plug 'LargeFile'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-scriptease'

  " TeX 
  Plug 'lervag/vimtex'
  Plug 'noweb.vim--McDermott'
  Plug 'rbonvall/vim-textobj-latex'

  " Vim Misc
  Plug 'kshenoy/vim-signature'
  Plug 'xolox/vim-misc'
  "Plug 'xolox/vim-easytags'
  Plug 'xolox/vim-notes'
  Plug 'OnSyntaxChange'
  "Plug 'ktonga/vim-follow-my-lead'
  
  " Theming
  Plug 'bling/vim-airline'
  Plug 'altercation/vim-colors-solarized'

call plug#end() 

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
let python_space_error_highlight = 1 
" }}}

" Terminal {{{
set ttyfast

" }}}

" Mapping {{{
let mapleader='\'
let maplocalleader=','

"if exists("b:loaded_repl") 
  nnoremap <silent> <LocalLeader>tr :ReplSpawnTermCmd<CR>
  nnoremap <silent> <LocalLeader>td :ReplSpawnTermDebugCmd<CR>
  nnoremap <silent> <LocalLeader>tq :ReplCloseTermCmd<CR>
  nnoremap <silent> <LocalLeader>ts :ReplSendSelectionCmd n<CR>
  vnoremap <silent> <LocalLeader>ts :ReplSendSelectionCmd v<CR>
  nnoremap <silent> <LocalLeader>tl :ReplSendLineCmd<CR>
  nnoremap <silent> <LocalLeader>tf :ReplSendFileCmd<CR>
"endif

set noto
set timeoutlen=50
if has("nvim")
  " allow us to easily use window motions in a terminal
  tnoremap <c-w> <c-\><c-n><c-w>
  " leave insert mode in terminal with ESC
  tnoremap <Esc> <C-\><C-N>
endif

" Use Ctrl+Space to do omnicompletion:
if has("gui_running")
  "set term=$TERM
  "set noguipty
  inoremap <C-Space> <C-x><C-o>
else
  inoremap <Nul> <C-x><C-o>
endif

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
"let g:python2_host_prog='/usr/bin/python'
"let g:python3_host_prog='/usr/bin/python3'
"let g:pymode_indent = 0
command PythonAutopep8 :!autopep8 --in-place %
" }}}

" Editing Text {{{
set showmatch
set backspace=indent,eol,start
set completeopt=longest,menuone,preview,noinsert
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
" }}}

" Messages and Info {{{
set showcmd
"set noshowmode
"set showmode
" }}}

" Functions {{{

" This just feels super hackish: we're extracting the string name
" of the function that `b:ReplSendFile` currently references, then
" we're creating another function reference for that.
" This way we avoid creating a recursive `b:ReplSendString` (just in case).
function! CopyFuncRef(funcref)
  let t:default_funcref = string(a:funcref)
  let t:default_funcname = matchstr(t:default_funcref, '\vfunction\(''\zs(.*)\ze''\)')
  return function(t:default_funcname) 
endfunction

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

"autocmd BufNew,BufReadPre * :runtime! repl.vim 

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

" surround {{{
" TODO: how to delete/change?
let g:surround_108 = "\\begin{\1\\begin{\1}\n\r\n\\end{\1\r}.*\r\1}" 
" }}}

" python-mode {{{
let g:pymode_run = 0
let g:pymode_lint_cwindow = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = '' "'<C-Space>' 
let g:pymode_breakpoint = 1 
let g:pymode_breakpoint_bind = '<localleader>b'
let g:pymode_breakpoint_cmd = '%debug '
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_rope_goto_definition_bind = '<localleader>gd' 
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_project_root = $VIRTUAL_ENV
let g:pymode_rope_show_doc_bind = '<localleader>K' 
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
"deoplete#sources#jedi#show_docstring
if has("gui_running")
    inoremap <silent><expr> <C-Space>
    \ pumvisible() ? "\<C-n>" :
    \ deoplete#mappings#manual_complete()
else
    inoremap <silent><expr> <Nul>
    \ pumvisible() ? "\<C-n>" :
    \ deoplete#mappings#manual_complete()
endif
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}

" autopep8 {{{
let g:autopep8_disable_show_diff=1 
" }}}

" syntastic {{{ 
let g:syntastic_python_checkers = ['flake8'] 
let g:syntastic_enable_highlighting = 1  
let g:syntastic_style_error_symbol = "E>" 
let g:syntastic_warning_symbol = "W>" 
let g:syntastic_auto_jump = 0  
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}

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
let g:tex_flavor = "latex"
let g:vimtex_fold_enabled = 0

if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns = {}
endif
let g:deoplete#omni_patterns.tex =
      \ '\v\\%('
      \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|%(include%(only)?|input)\s*\{[^}]*'
      \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . ')\m'
let g:vimtex_latexmk_build_dir = '../../output'
" }}}

" NERDCommenter {{{
let g:NERDAllowAnyVisualDelims=1
let g:NERDCommentWholeLinesInVMode=1
let g:NERDRemoveAltComs=1
let g:NERDRemoveExtraSpaces=1
let g:NERDDefaultNesting=1
" }}}

" YouCompleteMe {{{
let g:ycm_auto_trigger = 0
"let g:ycm_python_binary_path = ''
"let g:ycm_key_invoke_completion = '<Nop>' "'<C-Space>' 
let g:ycm_autoclose_preview_window_after_completion = 1 
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<C-N>']
let g:ycm_key_list_select_previous_completion = ['<C-P>']
let g:ycm_cache_omnifunc = 1 
let g:ycm_use_ultisnips_completer = 1
let g:ycm_goto_buffer_command = 'horizontal-split'
" }}}

" Jedi {{{
"let g:jedi#use_splits_not_buffers = "left"
"let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
"let g:jedi#show_call_signatures = "2"
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-N>"
"let g:jedi#rename_command = "<leader>r"
"let g:jedi#auto_vim_configuration = 0
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

" vim-notes {{{
let g:notes_directories = ['~/projects/notes']
let g:notes_markdown_program = 'pandoc' "'pandoc -f markdown_github -t html'
let g:notes_conceal_code = 0
let g:notes_suffix = '.vmd'
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

" ultisnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
" }}}

" vim:foldmethod=marker:foldlevel=0

"
" Check the folds below for settings.
" Otherwise, see the after/ ftplugins/ and other directories.
"
" Some content inspired by the following:
" * https://github.com/justinmk/config/blob/7b97ae50b5377b35d37128fe1225c47e5fcba7d0/.vimrc#L1021
" * http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
" * https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments
" * https://github.com/mbadran/headlights/blob/master/plugin/headlights.vim
" * http://vim.wikia.com/wiki/Capture_ex_command_output
" * http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" * https://github.com/blueyed/dotfiles/blob/master/vimrc
"
" -brandonwillard
"


" Important {{{

" Plugins Config {{{
call plug#begin('~/.vim/bundle/') 

  "## Syntax, Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
  " XXX: Broken python rope 
  "Plug 'SirVer/ultisnips', {'do': ':UpdateRemotePlugins'} 
  Plug 'honza/vim-snippets'
  "Plug 'valloric/YouCompleteMe'
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  else
    " TODO: add neocomplete
  endif
  Plug 'tpope/vim-commentary'
  " Plug 'scrooloose/syntastic'
  Plug 'w0rp/ale'
  " Plug 'Rykka/riv.vim', { 'for': ['python', 'rst']}

  "# Motion, Buffers, Windows
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'qpkorr/vim-bufkill'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'sgur/vim-textobj-parameter'
  Plug 'tpope/vim-surround'
  " -- Make `.` work for maps and `<Plug>`s:
  Plug 'tpope/vim-repeat'

  "# Python
  Plug 'bps/vim-textobj-python', {'for': '*python*'}
  Plug 'python-mode/python-mode', {'for': '*python*'}
  Plug 'davidhalter/jedi-vim'
  Plug 'tmhedberg/SimpylFold'
  "Plug 'jmcantrell/vim-virtualenv'
  "Plug 'tell-k/vim-autopep8'
  "Plug 'jimf/vim-pep8-text-width'
  "Plug 'hynek/vim-python-pep8-indent'
  "Plug 'hdima/python-syntax'
  "Plug 'ivanov/vim-ipython', {'for': '*python*'} 
  if has('nvim')
    Plug 'zchee/deoplete-jedi', { 'for': '*python*'} 
    "Plug 'bfredl/nvim-ipy', {'do': ':UpdateRemotePlugins', 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-ipy', {'do': ':UpdateRemotePlugins', 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-jupyter', {'do': ':UpdateRemotePlugins', 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-example-python-plugin', {'do': ':UpdateRemotePlugins'} 
  else
  endif

  "# R
  if has('nvim')
    Plug 'jalvesaq/Nvim-R', { 'for': ['r', 'rnoweb', 'rmd']} 
  else
    Plug 'jalvesaq/R-Vim-runtime', { 'for': ['r', 'rnoweb', 'rmd']}
    Plug 'jcfaria/Vim-R-plugin', { 'for': ['r', 'rnoweb', 'rmd']}
  endif

  "# Terminal/REPL
  Plug 'brandonwillard/vimcmdline'

  "# Filesystem, Make, Git 
  Plug 'benekastah/neomake'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/LargeFile'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-scriptease'
  Plug 'tpope/vim-projectionist'

  "# TeX 
  Plug 'lervag/vimtex', {'for': ['tex', 'noweb']}
  Plug 'rbonvall/vim-textobj-latex', {'for': ['tex', 'noweb']}

  "# Vim Misc
  Plug 'rhysd/vim-grammarous'
  Plug 'kshenoy/vim-signature'
  Plug 'xolox/vim-misc'
  "Plug 'xolox/vim-easytags'
  Plug 'xolox/vim-notes'
  Plug 'vim-scripts/OnSyntaxChange'
  "Plug 'ktonga/vim-follow-my-lead'
  Plug 'vim-scripts/genutils'
  Plug 'albfan/vim-breakpts' 
  " Plug 'Konfekt/FastFold'

  "# Theming
  Plug 'bling/vim-airline'
  " Plug 'altercation/vim-colors-solarized'
  Plug 'google/vim-colorscheme-primary'

call plug#end() 

" }}}
filetype plugin indent on
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

" if exists('+breakindent')
"   set breakindent
"   set breakindentopt=min:20,shift:0,sbr
" endif

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

" Clear highlighting with <C-l>, too
nnoremap <c-l> <c-l>:noh<cr>
" }}}

" Multiple Windows {{{
set hid
set ls=2
set switchbuf=useopen
" }}}

" Syntax, Highlighting and Spelling {{{
set hls

" When it's really slow, try something like this:
" set synmaxcol=200

syntax enable

autocmd BufEnter * :syn sync maxlines=200
autocmd BufEnter * :syn sync minlines=50

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
set timeoutlen=50
if has("nvim")
  " allow us to easily use window motions in a terminal
  tnoremap <C-w> <C-\><C-n><C-w>
  " leave insert mode in terminal with ESC
  tnoremap <Esc> <C-\><C-N>
endif

" Use Ctrl+Space to do omnicompletion:
" if has("gui_running")
"   "set term=$TERM
"   "set noguipty
"   inoremap <C-Space> <C-x><C-o>
" else
"   inoremap <Nul> <C-x><C-o>
" endif

" disable Ex mode key 
noremap Q <Nop>

map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>
map <F7> :syn sync fromstart<CR>

" -- Basic motions aren't affected by line wrapping:
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" helper for debugging syntax code:
"map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" }}}

" Appearance {{{
set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dmu

try
  colorscheme primary
catch /.*/
  "echo v:exception
endtry

set background=dark

highlight clear comment
highlight comment ctermfg=blue
highlight clear SpellBad
highlight SpellBad cterm=undercurl ctermfg=red
" Clear Search?
highlight Search cterm=NONE ctermbg=yellow

" Stop matchparen from making it look like the cursor has jumped
" to the match.
" Clear MatchParen?
highlight MatchParen ctermbg=NONE ctermfg=blue guibg=NONE guifg=lightblue

set wrap
set linebreak
set nolist
" }}}

" Python {{{
" We should have separate pyenv virtualenvs for python 2 and 3.
" The host progs should point to those.
"
let g:python_host_prog=expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog=expand('~/.pyenv/versions/neovim3/bin/python')
let python_space_error_highlight = 1 

""
" Run `autopep8` on the current buffer in-place.
command PythonAutopep8 :!autopep8 --in-place %
" }}}

" Editing Text {{{
set pastetoggle=<F2>
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
set selection=exclusive
set clipboard+=unnamedplus
"if has('X11') && has('gui')
"    set clipboard+=unnamedplus
"endif
" }}}

" Various {{{
set virtualedit=insert,block,onemore
set nocursorline

if $VIRTUAL_ENV != ""
  let &tags = $VIRTUAL_ENV.'/tags,' . &tags
endif
" }}}

" Messages and Info {{{
set showcmd
set showmode
" }}}

" Functions {{{

""
" Create a copy of a function reference.
" This just feels super hackish: we're extracting the string name
" of the function that `b:ReplSendFile` currently references, then
" we're creating another function reference for that.
" This way we avoid creating a recursive `b:ReplSendString` (just in case).
function! CopyFuncRef(funcref)
  let t:default_funcref = string(a:funcref)
  let t:default_funcname = matchstr(t:default_funcref, '\vfunction\(''\zs(.*)\ze''\)')
  return function(t:default_funcname) 
endfunction

""
" Capture and return the output of a vim/ex command.
" Initialise to a blank value in case the command throws a vim error
" (XXX: try-catch doesn't always work here, for some reason).
function! GetVimCommandOutput(command) 
  let l:output = ''

  redir => l:output
    execute "silent verbose " . a:command
  redir END

  return l:output
endfunction

""
" Capture output of ex commands.
" This function output the result of the ex command into a split scratch
" buffer.
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

""
" Ex command for @function(OutputSplitWindow).
command! -nargs=+ -complete=command Output call OutputSplitWindow(<f-args>)

" }}}

" Autocommands {{{

"autocmd BufNew,BufReadPre * :runtime! repl.vim 

""
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. `Foldmethod` is local to the window. Protect against
" screwing up folding when switching between windows.
" These two `autocmd`s do just that.
augroup fix_folds
	au!
	au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
	au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
augroup END

""
" Restore cursor position on file open (see :help restore-cursor).
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

" Omni/popup settings from here:
" if has("autocmd") && exists("+omnifunc")
"   autocmd Filetype *
"         \	if &omnifunc == "" |
"         \		setlocal omnifunc=syntaxcomplete#Complete |
"         \	endif
" endif  
"
" }}}

" Latex {{{
let g:tex_fold_enabled=0
let g:tex_flavor = "latex"
" let g:tex_fast = "bcmMsrV"
" }}}


"
" [Generally] global plugin settings from here on.
"

" vimcmdline {{{

let g:cmdline_map_start = "<LocalLeader>tr"
let g:cmdline_map_send = "<LocalLeader>tl"
let g:cmdline_map_send_selection = "<LocalLeader>ts"
let g:cmdline_map_source_fun = "<LocalLeader>tf"
let g:cmdline_map_send_paragraph = "<LocalLeader>tp"
let g:cmdline_map_send_block = "<LocalLeader>tb"
let g:cmdline_map_quit = "<LocalLeader>tq"

function! ReplGetSelection(curmode) range		
  "		
  " This function gets either the visually selected text,		or the current
  " <cWORD>.		
  "		
  if (a:firstline == 1 && a:lastline == line('$')) || a:curmode == "n"		
    return expand('<cWORD>')		
  endif		
  let [lnum1, col1] = getpos("'<")[1:2]		
  let end_pos = getpos("'>")		
  let [lnum2, col2] = end_pos[1:2]		
  let lines = getline(lnum1, lnum2)		
		
  let mode_offset = 1		
  if &selection == 'exclusive'		
    let mode_offset = 2		
  endif		
		
  let lines[-1] = lines[-1][:(col2 - mode_offset)]		
  let lines[0] = lines[0][col1 - 1:]		
		
  " Sends the cursor to the beginning of the last visual select		
  " line.  We probably want to leave the cursor at the end of the		
  " visually selected region instead.		
  "call cursor(lnum2, 1)		
  execute "normal! gv\<Esc>"		
  return lines
endfunction

command! -range -nargs=1 ReplSendSelectionCmd 
      \call b:cmdline_source_fun(ReplGetSelection(<f-args>)) 

exe 'nnoremap <silent><buffer> ' . g:cmdline_map_send_selection . 
      \' :ReplSendSelectionCmd n<CR>'
exe 'vnoremap <silent><buffer> '. g:cmdline_map_send_selection . 
      \' :ReplSendSelectionCmd v<CR>'

let g:cmdline_vsplit = 0
let g:cmdline_esc_term = 1
let g:cmdline_in_buffer = 1 
let g:cmdline_outhl = 0
let g:cmdline_app = {}

" Custom options
let g:cmdline_nolisted = 1
let g:cmdline_golinedown = 0

" }}}

" vimtex {{{
"let g:vimtex_complete_enabled=0
let g:vimtex_latexmk_enabled=0
let g:vimtex_latexmk_callback=0
let g:vimtex_latexmk_continuous=0
let g:vimtex_latexmk_build_dir = '../../output'

let g:vimtex_view_enabled=0
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
  \ = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'

let g:vimtex_indent_enabled=1
let g:vimtex_indent_bib_enabled=0
" let g:vimtex_fold_enabled = 1
" let g:vimtex_delim_stopline = 300

let g:vimtex_syntax_minted = [
      \{
      \   'lang' : 'python',
      \   'ignore' : [
      \     'pythonEscape',
      \     'pythonBEscape',
      \     ],
      \ }
      \]
" }}}

" neomake {{{

let g:neomake_serialize = 1
let g:neomake_open_list = 2
" let g:neomake_serialize_abort_on_error = 1
" let g:neomake_remove_invalid_entries = 1

" FYI: See `after/ftplugin/tex.vim` for more neomake settings.
"
" TODO: Consider using latexrun
" let g:neomake_tex_enabled_makers = ['latexrun']

" }}}

" surround {{{
" TODO: how to delete/change?
let g:surround_108 = "\\begin{\1\\begin{\1}\n\r\n\\end{\1\r}.*\r\1}" 
" }}}

" python-mode {{{

" Don't let pymode set options; we should do this ourselves. 
let g:pymode_options=0
let g:pymode_debug = 1
let g:pymode_run = 1

let g:pymode_lint = 0
let g:pymode_lint_cwindow = 0

let g:pymode_breakpoint = 1 
let g:pymode_breakpoint_bind = '<localleader>b'
" let g:pymode_breakpoint_cmd = '%debug '
let g:pymode_breakpoint_cmd = 'from IPython.core.debugger import set_trace; set_trace()'
let g:pymode_options_colorcolumn = 0

let g:pymode_motion = 0

let g:pymode_folding = 0

let g:pymode_syntax = 0
let g:pymode_syntax_all = 0
let g:pymode_syntax_slow_sync = 1

let g:pymode_doc = 0

" XXX: enable only for pure python files; no mixed/noweb files!
let g:pymode_rope = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = '' "'<C-Space>' 
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_rope_goto_definition_bind = '<localleader>gd' 
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_project_root = $VIRTUAL_ENV
let g:pymode_rope_show_doc_bind = '<localleader>K' 
" }}}

" deoplete {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
"let g:deoplete#complete_method = 'omnifunc'
"deoplete#sources#jedi#show_docstring

inoremap <silent><expr> <C-Space>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<C-Space>" :
    \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"let g:deoplete#omni_patterns = []

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" Settings for vimtex
let g:deoplete#omni#input_patterns.tex = '\\(?:'
    \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
    \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
    \ . '|hyperref\s*\[[^]]*'
    \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
    \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
    \ .')'

" }}}

" autopep8 {{{
let g:autopep8_disable_show_diff=1 
" }}}

" syntastic {{{ 
" let g:syntastic_python_checkers = ['flake8'] 
" let g:syntastic_enable_highlighting = 1  
" let g:syntastic_style_error_symbol = "E>" 
" let g:syntastic_warning_symbol = "W>" 
" let g:syntastic_auto_jump = 0  
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" }}}

" ale {{{
" let g:ale_lint_on_text_changed='never'
" }}}

" R-plugin {{{
" don't select the first option that pops up.
let R_user_maps_only = 1   
let R_insert_mode_cmds = 0 
let R_assign = 0

let R_pdfviewer = "qpdfview"
let g:rplugin_has_wmctrl = 1
let rmd_syn_hl_chunk = 1

"let vimrplugin_source_args = 'local = TRUE'
let R_source_args = 'local=T, echo=T, print.eval=T'

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

" NERDCommenter {{{
let g:NERDAllowAnyVisualDelims=1
let g:NERDCommentWholeLinesInVMode=1
let g:NERDRemoveAltComs=1
let g:NERDRemoveExtraSpaces=1
let g:NERDDefaultNesting=1
" }}}

" YouCompleteMe {{{
" let g:ycm_auto_trigger = 0
" "let g:ycm_python_binary_path = ''
" "let g:ycm_key_invoke_completion = '<Nop>' "'<C-Space>' 
" let g:ycm_autoclose_preview_window_after_completion = 1 
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_key_list_select_completion = ['<C-N>']
" let g:ycm_key_list_select_previous_completion = ['<C-P>']
" let g:ycm_cache_omnifunc = 1 
" let g:ycm_use_ultisnips_completer = 1
" let g:ycm_goto_buffer_command = 'horizontal-split'
" }}}

" jedi {{{
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#rename_command = '<localleader>gR'
let g:jedi#usages_command = '<localleader>gu'
let g:jedi#smart_auto_mappings = 1
let g:jedi#auto_close_doc = 1
"let g:jedi#documentation_command = "K"
"let g:jedi#use_splits_not_buffers = "left"
"let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
"let g:jedi#show_call_signatures = "2"
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-N>"
"let g:jedi#rename_command = "<leader>r"

nnoremap <localleader>gd :<C-u>call jedi#goto()<CR>zv
autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsListSnippets="<F3>"
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

" youcompleteme {{{
let g:ycm_auto_trigger=0
let g:ycm_key_invoke_completion = '<C-space>'
let g:ycm_key_list_select_completion = ['<C-tab>', '<down>']
let g:ycm_key_list_select_previous_completion = ['<C-s-tab>', '<up>']
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
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
" }}}

" vim-grammarous {{{

" https://stackoverflow.com/questions/43574426/how-to-resolve-java-lang-noclassdeffounderror-javax-xml-bind-jaxbexception-in-j
" let g:grammarous#java_cmd = "java --add-modules java.se.ee"
let g:grammarous#use_vim_spelllang = 0
let g:grammarous#enable_spell_check = 1

" }}}

" vim-projectionist {{{

"""
" Create a projection named 'let' that lets a variable using the given
" pair of values.
" E.g.
"
" let g:projectionist_heuristics = {"src/tex/&output/": {
"       \"*.tex": {
"       \"let": ["b:tex_blah", '"bloh"']
"       \}}
"       \}
"
autocmd User ProjectionistActivate call s:proj_activate()
function! s:proj_activate() abort
  for [root, value] in projectionist#query('let')
    for l:let_var in value
      let l:exec_str = "let ".let_var[0]."=".let_var[1]
      call xolox#misc#msg#debug("proj_activate:".l:exec_str)
      execute(l:exec_str) 
    endfor
    break
  endfor
endfunction

" }}}

" vim:foldmethod=marker:foldlevel=0

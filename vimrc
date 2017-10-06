"
" Check the folds below for settings.  Otherwise, see the after/ ftplugins/
" and other directories.
"
" Some content inspired by the following:
" * https://github.com/justinmk/config/blob/7b97ae50b5377b35d37128fe1225c47e5fcba7d0/.vimrc#L1021
" * http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
" * https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments
" * https://github.com/mbadran/headlights/blob/master/plugin/headlights.vim
" * http://vim.wikia.com/wiki/Capture_ex_command_output
" * http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" * https://github.com/blueyed/dotfiles/blob/master/vimrc
" * https://github.com/junegunn/dotfiles/blob/master/vimrc
"
" -brandonwillard
"

" Important {{{

" See https://github.com/junegunn/vim-plug/issues/432
function! s:on_load(name, exec)
  if !has_key(g:plugs, a:name)
    return
  endif
  " TODO: Automate the naming convention for a:exec setup functions.
  if has_key(g:plugs[a:name], 'on') || has_key(g:plugs[a:name], 'for')
    execute 'autocmd! User' a:name a:exec
  else
    execute 'autocmd VimEnter *' a:exec
  endif
endfunction

function! PlugLocal(plugin, local_path, remote_path, opts)
  let l:local_plugin_path = a:local_path . '/' . a:plugin
  if !empty(glob(l:local_plugin_path))
    let l:plugin_loc = l:local_plugin_path
  else
    let l:plugin_loc = a:remote_path . '/' . a:plugin
  endif
  Plug l:plugin_loc, a:opts
endfunction

let g:local_plugins_path = '~/projects/code/vim-plugins' 

" Plugins Config {{{
call plug#begin('~/.vim/bundle/') 

  " Vim Functionality
  Plug 'tpope/vim-projectionist'
  Plug 'junegunn/vim-peekaboo'
  Plug 'Shougo/echodoc.vim'
  Plug 'tpope/vim-sensible'
  Plug 'itchyny/vim-parenmatch'
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
  Plug 'terryma/vim-multiple-cursors'
  Plug 'Raimondi/delimitMate'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  if has('nvim')
    " Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}
  endif

  "# Theming
  Plug 'bling/vim-airline'
  Plug 'guns/xterm-color-table.vim'
  " Plug 'altercation/vim-colors-solarized'
  Plug 'google/vim-colorscheme-primary'

  "## Syntax, Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
  " XXX: Broken python rope 
  "Plug 'SirVer/ultisnips', {'do': ':UpdateRemotePlugins'} 
  Plug 'honza/vim-snippets'
  Plug 'tpope/vim-commentary'
  " Plug 'scrooloose/syntastic'
  " Plug 'Rykka/riv.vim', { 'for': ['python', 'rst']}
  Plug 'lifepillar/pgsql.vim', { 'for': ['sql']}
  if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins',
          \ 'for': ['python', 'c', 'cpp']}
    Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  else
    " TODO: add neocomplete
    "Plug 'valloric/YouCompleteMe'
  endif

  "# Motion, Buffers, Windows
  if !has("nvim")
    Plug 'christoomey/vim-tmux-navigator'
  endif
  " XXX: Breaks `undolevel` when using terminal buffers.
  " Plug 'Lokaltog/vim-easymotion'
  Plug 'justinmk/vim-sneak'
  Plug 'qpkorr/vim-bufkill'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-line'
  Plug 'sgur/vim-textobj-parameter'
  Plug 'tpope/vim-surround'
  " -- Make `.` work for maps and `<Plug>`s:
  Plug 'tpope/vim-repeat'
  Plug 'junegunn/vim-slash'

  "# Python
  Plug 'bps/vim-textobj-python', {'for': '*python*'}
  Plug 'python-mode/python-mode', {'for': '*python*'}
  Plug 'tmhedberg/SimpylFold', {'for': '*python*'}
  Plug 'Chiel92/vim-autoformat', {'for': '*python*'}
  Plug 'Integralist/vim-mypy', {'for': '*python*'}
  " Plug 'davidhalter/jedi-vim', {'for': '*python*'}
  "Plug 'jmcantrell/vim-virtualenv', {'for': '*python*'}
  "Plug 'tell-k/vim-autopep8', {'for': '*python*'}
  "Plug 'jimf/vim-pep8-text-width', {'for': '*python*'}
  "Plug 'hynek/vim-python-pep8-indent', {'for': '*python*'}
  "Plug 'hdima/python-syntax', {'for': '*python*'}
  "Plug 'ivanov/vim-ipython', {'for': '*python*'} 
  if has('nvim')
    " Plug 'zchee/deoplete-jedi', { 'for': '*python*'} 
    "Plug 'bfredl/nvim-ipy', {'do': ':UpdateRemotePlugins', 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-ipy', {'do': ':UpdateRemotePlugins', 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-jupyter', {'do': ':UpdateRemotePlugins', 'for': '*python*'} 
    "Plug '~/.vim/dev/nvim-example-python-plugin', {'do': ':UpdateRemotePlugins', 'for': '*python*'} 
  endif

  "# C++
  if has('nvim')
    " NOTE: Using LanguageServer now.
    " Plug 'zchee/deoplete-clang', { 'for': ['cpp', 'c'] }
  endif
  Plug 'vhdirk/vim-cmake', { 'for': ['cpp', 'c'] }

  "# R
  let r_ftypes = ['r', 'rnoweb', 'rmd']
  if has('nvim')
    Plug 'jalvesaq/Nvim-R', { 'for': r_ftypes} 
  else
    Plug 'jalvesaq/R-Vim-runtime', { 'for': r_ftypes}
    Plug 'jcfaria/Vim-R-plugin', { 'for': r_ftypes}
  endif

  "# Terminal/REPL
  call PlugLocal('vimcmdline', g:local_plugins_path,
        \ 'brandonwillard',
        \ { 'for': ['python', 'noweb', 'sql', 'clojure', 'javascript'] })

  "# Filesystem, Make, Git 
  Plug 'tpope/vim-fugitive'
  Plug 'vim-scripts/LargeFile'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-scriptease'
  Plug 'w0rp/ale'
  Plug 'editorconfig/editorconfig-vim'
  if has('nvim')
    Plug 'benekastah/neomake'
  endif

  "# TeX 
  let tex_ftypes = ['tex', 'noweb']
  Plug 'lervag/vimtex', {'for': tex_ftypes}
  Plug 'rbonvall/vim-textobj-latex', {'for': tex_ftypes}

  "# Noweb
  call PlugLocal('vim-noweb', g:local_plugins_path,
        \ 'brandonwillard', { 'for': ['*noweb*'] } )

call plug#end() 

" }}}
filetype plugin indent on
" }}}

" Tabs and Indenting {{{
set copyindent
set pi
" NOTE: Covered by vim-sensible
" set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set cinkeys-=0#
set indentkeys-=0#

" if exists('+breakindent')
"   set breakindent
"   set breakindentopt=min:20,shift:0,sbr
" endif

" }}}

" Command Line Editing {{{
set wildmode=longest:full
" NOTE: Covered by vim-sensible
" set wildmenu
" }}}

" Reading and Writing Files {{{
let g:LargeFile=1024/2 " in MB
set modeline
set modelines=1

" Allow local init files:
" set exrc
" }}}

" Moving Around, Searching and Patterns {{{
set nostartofline
set nows

" NOTE: Covered by vim-sensible
" Clear highlighting with <C-l>, too
" nnoremap <c-l> <c-l>:noh<cr>
" }}}

" Multiple Windows {{{
set hid
" NOTE: Covered by vim-sensible
" set ls=2
set switchbuf=useopen
set splitbelow
set splitright
" }}}

" Terminal {{{
set ttyfast
set scrollback=1000
" }}}

" Mapping {{{
let mapleader='\'
let maplocalleader=','

set noto
set timeoutlen=50
if has("nvim")
  " Allow us to easily use window motions in a terminal
  tnoremap <C-w> <C-\><C-n><C-w>
  " Leave insert mode in terminal with <Esc>
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

" Debug syntax highlighting.
map <F10> :echo printf("hi<%s> trans<%s> lo<%s>", synIDattr(synID(line("."),col("."),1),"name"), synIDattr(synID(line("."),col("."),0),"name"), synIDattr(synIDtrans(synID(line("."),col("."),1)),"name"))<CR>

" -- Basic motions aren't affected by line wrapping:
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" }}}

" Syntax, Highlighting and Spelling {{{

syntax enable

set t_Co=256
"set t_AB=^[[48;5;%dm
"set t_AF=^[[38;5;%dmu

set background=dark

try
  colorscheme primary
  set background=dark
catch /.*/
  echom v:exception
endtry

" XXX: The following must come *after* the colorscheme is set.
set hlsearch

set wrap
set linebreak
set nolist

set cmdheight=1
" autocmd BufEnter * :syn sync maxlines=200
" autocmd BufEnter * :syn sync minlines=50
" When it's really slow, try something like this:
" set synmaxcol=200

syn spell default
"set spelllang=en_us

" FYI: Use `:XtermColorTable` to see numeric mappings.
highlight clear Comment
highlight Comment cterm=italic ctermfg=blue
highlight clear SpellBad
highlight SpellBad cterm=undercurl ctermfg=red
highlight SpellCap ctermbg=18
" Clear Search?
highlight Search cterm=NONE ctermbg=yellow

" Stop matchparen from making it look like the cursor has jumped to the match.
" Clear MatchParen?
highlight MatchParen ctermbg=NONE ctermfg=blue guibg=NONE guifg=lightblue

let g:loaded_matchparen = 1

" }}}

" Python {{{
" We should have separate pyenv virtualenvs for python 2 and 3.
" The host progs should point to those.
"
" let g:python_host_prog=expand('~/.pyenv/versions/neovim2/bin/python')
" let g:python3_host_prog=expand('~/.pyenv/versions/neovim3/bin/python')
" let g:python3_host_prog=expand('~/.pyenv/versions/neovim36/bin/python')
let g:python_host_prog=expand('/home/bwillard/apps/anaconda3/envs/neovim2/bin/python')
let g:python3_host_prog=expand('/home/bwillard/apps/anaconda3/envs/neovim3/bin/python')
let python_space_error_highlight = 1 

if $CONDA_PREFIX != ""
  let &tags = $CONDA_PREFIX.'/tags,' . &tags
endif

if $VIRTUAL_ENV != ""
  let &tags = $VIRTUAL_ENV.'/tags,' . &tags
endif

""
" Run `autopep8` on the current buffer in-place.
" command PythonAutopep8 :!autopep8 --in-place %

" }}}

" Editing Text {{{
set pastetoggle=<F2>
set showmatch
" NOTE: Covered by vim-sensible
" set backspace=indent,eol,start
set completeopt=longest,menuone,preview,noinsert
set whichwrap=b,s,h,l,<,>,[,]
" }}}

" Displaying Text {{{
set number
" NOTE: Covered by vim-sensible
" set scrolloff=8
set conceallevel=0
set shortmess=aIT

set list
set listchars=tab:\|\ ,

if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

" }}}

" Folding {{{
set foldmethod=syntax
"set foldnestmax=1tte
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldclose=""

""
" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. `Foldmethod` is local to the window. Protect against
" screwing up folding when switching between windows.  These two `autocmd`s do
" just that.
" (https://stackoverflow.com/a/42287519)
augroup fix_folds
  au!
  " autocmd InsertLeave,WinEnter * let &l:foldmethod=g:oldfoldmethod
  " autocmd InsertEnter,WinLeave * let g:oldfoldmethod=&l:foldmethod | setlocal foldmethod=manual
  au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  au InsertLeave,WinEnter, * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  au InsertLeave,BufWritePost,TextYankPost * normal! zv
augroup END
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
set autoread
set path+=.

let g:sql_type_default = 'pgsql'
" }}}

" Messages and Info {{{
set noshowcmd
set noshowmode
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
" Get the Python version in a Jupyter kernel string format
" (e.g. 'python', 'python2', 'python3').
"
function! GetPythonVersion()

  let l:python_version = system('python -V')

  if l:python_version =~? '^Python 3\.\?'
    let l:python_version = '3'
  elseif l:python_version =~? '^Python 2\.\?'
    let l:python_version = '2'
  else
    let l:python_version = ''
  endif

  return printf('python%s', l:python_version)

endfunction

""
" Ex command for @function(OutputSplitWindow).
command! -nargs=+ -complete=command Output call OutputSplitWindow(<f-args>)

" }}}

" Autocommands {{{

"autocmd BufNew,BufReadPre * :runtime! repl.vim 

""
" Restore cursor position on file open (see :help restore-cursor).
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Omni/popup settings from here:
" if has("autocmd") && exists("+omnifunc")
"   autocmd Filetype *
"         \ if &omnifunc == "" |
"         \   setlocal omnifunc=syntaxcomplete#Complete |
"         \ endif
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
function! s:PreSetupVimcmdline()
  let g:cmdline_map_start = "<LocalLeader>tr"
  let g:cmdline_map_send = "<LocalLeader>tl"
  let g:cmdline_map_send_selection = "<LocalLeader>ts"
  let g:cmdline_map_source_fun = "<LocalLeader>tf"
  let g:cmdline_map_send_paragraph = "<LocalLeader>tp"
  let g:cmdline_map_send_block = "<LocalLeader>tb"
  let g:cmdline_map_quit = "<LocalLeader>tq"

  let g:cmdline_term_height = -1
  let g:cmdline_term_width = -1

  let g:cmdline_vsplit = 0
  let g:cmdline_esc_term = 1
  let g:cmdline_in_buffer = 1 
  let g:cmdline_outhl = 0
  " let g:cmdline_app = {}
  
  " Custom options
  let g:cmdline_nolisted = 0
  let g:cmdline_golinedown = 0

  " Enable (and likewise disable) bracketed paste mode in the terminal.
  let &t_ti .= "\<Esc>[?2004h"
  let &t_te .= "\<Esc>[?2004l"

  if !exists("g:cmdline_bps")
    let g:cmdline_bps = "\x1b[200~"
  endif

  if !exists("g:cmdline_bpe")
    let g:cmdline_bpe = "\x1b[201~"
  endif

  " Use this to set a connection string (e.g. "--existing kernel.json --ssh jupyterhub")
  let g:cmdline_jupyter_opts = ''
  " Don't use jupyter console app by default.
  let g:cmdline_jupyter = 0

endfunction

function! s:PostSetupVimcmdline()
  
  exe 'nmap <silent> ' . g:cmdline_map_send . ' <Plug>(cmdline-send-line)'
  exe 'vmap <silent> ' . g:cmdline_map_send_selection . ' <Plug>(cmdline-send-selection)'
  exe 'nmap <silent> ' . g:cmdline_map_send_selection . ' <Plug>(cmdline-send-selection)'
  exe 'vmap <silent> ' . g:cmdline_map_send . ' <Plug>(cmdline-send-lines)'
  exe 'nmap <silent> ' . g:cmdline_map_source_fun . ' <Plug>(cmdline-send-file)'
  exe 'nmap <silent> ' . g:cmdline_map_send_paragraph . ' <Plug>(cmdline-send-paragraph)'
  exe 'nmap <silent> ' . g:cmdline_map_send_block . ' <Plug>(cmdline-send-mblock)'
  exe 'nmap <silent> ' . g:cmdline_map_quit . ' <Plug>(cmdline-send-quit)'
  exe 'nmap <silent> ' . g:cmdline_map_start . ' <Plug>(cmdline-send-start)'

  " XXX: This post setup only loads *once*, so buffer local settings aren't
  " reasonable.  That's what the following function does.
  " call VimCmdLineCreateMaps()

  function! g:ReplSendMultiline(lines)
    " Just for some background, you might see control/escape
    " sequences like `\x1b[200~` printed as `^[[200~`.  The
    " first part is, of course, the ESC control character
    " (ASCII: `^[`).  These exact control sequences are bracketed
    " paste modes in an xterm setting 
    "
    " References:
    " https://cirw.in/blog/bracketed-paste
    " http://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
    " http://www.xfree86.org/current/ctlseqs.html
    let l:expr_str = g:cmdline_bps
    let l:expr_str .= join(add(a:lines, ''), b:cmdline_nl)
    let l:expr_str .= g:cmdline_bpe
    let l:expr_str .= b:cmdline_nl

    call VimCmdLineSendCmd(l:expr_str)

  endfunction

  ""
  " Checks if `jupyter-console` command exists, then if a kernel
  " exists for the given kernel name, and returns a command string 
  " to start the console with the discovered kernel; otherwise,
  " an empty string.
  function! g:StartJupyterString(kernel)
    if !executable('jupyter-console')
      return ''
    endif

    let l:kernels_info = json_decode(system('jupyter-kernelspec list --json'))
    if !has_key(l:kernels_info['kernelspecs'], a:kernel)
      return ''
    endif

    let l:jupyter_opts = get(b:, 'cmdline_jupyter_opts', get(g:, 'cmdline_jupyter_opts', ''))
    let l:cmd_str = printf('jupyter-console --kernel %s %s', a:kernel, l:jupyter_opts)

    return l:cmd_str
  endfunction

endfunction

if has_key(g:plugs, 'vimcmdline')
  call s:PreSetupVimcmdline()
endif

call s:on_load('vimcmdline', 'call s:PostSetupVimcmdline()')
" }}}

" vimtex {{{
function! s:PreSetupVimtex()
  "let g:vimtex_complete_enabled=0
  let g:vimtex_latexmk_enabled=0
  let g:vimtex_latexmk_callback=0
  let g:vimtex_latexmk_continuous=0
  " let g:vimtex_latexmk_build_dir = '../../output'

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
endfunction

function! s:PostSetupVimtex()
  "no-op
endfunction

if has_key(g:plugs, 'vimtex')
  call s:PreSetupVimtex()
endif

call s:on_load('vimtex', 'call s:PostSetupVimtex()')
" }}}

" neomake {{{
function! s:PreSetupNeomake()
  let g:neomake_serialize = 1
  let g:neomake_open_list = 2
  " let g:neomake_serialize_abort_on_error = 1
  " let g:neomake_remove_invalid_entries = 1

  " FYI: See `after/ftplugin/tex.vim` for more neomake settings.
  "
  " TODO: Consider using latexrun
  " let g:neomake_tex_enabled_makers = ['latexrun']

  " Replace the builtin `make`:
  " See: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
  if v:version >= 7
    cabbrev <expr> make ((getcmdtype() == ':' && getcmdpos() >= 5)? 'Neomake' : 'make')
  endif
endfunction

function! s:PostSetupNeomake()
  " if has_key(g:plugs, 'neomake')
  "   " NOTE: This plugin variable is referencing a variable initialized by
  "   " projectionist (another plugin) and we're better off assuming that the
  "   " plugin evaluation orders aren't always certain/clear.
  "   " let l:Maker_val = {-> exists('b:neomake_tex_rubberinfo_maker') ? 
  "   "       \ extend(b:neomake_tex_rubberinfo_maker, {'args': ['--into', '{project}/output']}) :
  "   "       \ {}
  "   "       \}
  "   " let g:latex_project_let_vars['b:neomake_tex_rubberinfo_maker'] = l:Maker_val
  " endif
  
  if exists('b:latex_build_dir')
    let b:neomake_tex_rubberinfo_maker['args'] = ['--into', b:latex_build_dir]
  endif

endfunction

if has_key(g:plugs, 'neomake')
  call s:PreSetupNeomake()
endif

call s:on_load('neomake', 'call s:PostSetupNeomake()')
" }}}

" surround {{{
function! s:PreSetupSurround()
  " TODO: how to delete/change?
  let g:surround_108 = "\\begin{\1\\begin{\1}\n\r\n\\end{\1\r}.*\r\1}" 
endfunction

function! s:PostSetupSurround()
  "no-op
endfunction

if has_key(g:plugs, 'vim-surround')
  call s:PreSetupSurround()
endif

call s:on_load('vim-surround', 'call s:PostSetupSurround()')
" }}}

" python-mode {{{
function! s:PreSetupPymode()
  " Don't let pymode set options; we should do this ourselves. 
  let g:pymode_options=0
  let g:pymode_debug = 0
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

  if $CONDA_PREFIX != ""
    let g:pymode_rope_project_root = $CONDA_PREFIX
  elseif $VIRTUAL_ENV != ""
    let g:pymode_rope_project_root = $VIRTUAL_ENV
  endif

  let g:pymode_rope_show_doc_bind = '<localleader>K' 

endfunction

function! s:PostSetupPymode()
  "no-op
endfunction

if has_key(g:plugs, 'python-mode')
  call s:PreSetupPymode()
endif

call s:on_load('python-mode', 'call s:PostSetupPymode()')
" }}}

" deoplete {{{
function! s:PreSetupDeoplete()

  let g:deoplete#enable_at_startup = 1
  " let g:deoplete#disable_auto_complete = 1
  let g:deoplete#enable_refresh_always = 1
  " let g:deoplete#complete_method = 'omnifunc'
  
  call deoplete#custom#set('_', 'min_pattern_length', 2)

  let g:deoplete#sources = get(g:, 'deoplete#sources', {})
  let g:deoplete#sources._ = ['LanguageClient', 'omni', 'buffer'] ", 'ultisnips']
  let g:deoplete#sources.python = ['LanguageClient', 'omni']
  let g:deoplete#sources.cpp = ['LanguageClient', 'clang']

  let g:deoplete#omni#functions = get(g:, 'deoplete#omni#functions', {})
  let g:deoplete#omni#functions.python = ['pythoncomplete#Complete']
  " let g:deoplete#omni#functions.tex = ['vimtex#complete#omnifunc']

  " Vim regexp versions
  " let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})

  " Python3 regexp versions
  let g:deoplete#omni#input_patterns = get(g:, 'deoplete#omni#input_patterns', {})
  " let g:deoplete#omni#input_patterns.javascript = '[^. *\t]\.\w*'
  " let g:deoplete#omni#input_patterns.python = ''
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

endfunction

function! s:PostSetupDeoplete()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~? '\s'
  endfunction

  inoremap <silent><expr> <C-Space>
      \ pumvisible() ? "\<C-n>" : (
      \ <SID>check_back_space() ? "\<C-Space>" :
      \ execute(":call deoplete#mappings#manual_complete()"))

  snoremap <silent><expr> <C-Space>
      \ pumvisible() ? "\<C-n>" : (
      \ <SID>check_back_space() ? "\<C-Space>" :
      \ deoplete#mappings#manual_complete())

  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

endfunction

if has_key(g:plugs, 'deoplete.nvim')
  call s:PreSetupDeoplete()
endif

call s:on_load('deoplete.nvim', 'call s:PostSetupDeoplete()')
" }}}

" deoplete-jedi {{{
function! s:PreSetupDeopleteJedi()
  " https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim
  let g:deoplete#sources#jedi#python_path = expand('~/.pyenv/versions/neovim36/bin/python')
  let g:deoplete#sources#jedi#statement_length = 30
  let g:deoplete#sources#jedi#show_docstring = 1
  let g:deoplete#sources#jedi#short_types = 1
endfunction

function! s:PostSetupDeopleteJedi()
  "no-op
endfunction

if has_key(g:plugs, 'deoplete-jedi')
  call s:PreSetupDeopleteJedi()
endif

call s:on_load('deoplete-jedi', 'call s:PostSetupDeopleteJedi()')
" }}}

" autopep8 {{{
function! s:PreSetupAutopep8()
  let g:autopep8_disable_show_diff=1 
endfunction

function! s:PostSetupAutopep8()
  "no-op
endfunction

if has_key(g:plugs, 'autopep8')
  call s:PreSetupAutopep8()
endif

call s:on_load('autopep8', 'call s:PostSetupAutopep8()')
" }}}

" syntastic {{{ 
function! s:PreSetupSyntastic()
  " let g:syntastic_python_checkers = ['flake8'] 
  " let g:syntastic_enable_highlighting = 1  
  " let g:syntastic_style_error_symbol = "E>" 
  " let g:syntastic_warning_symbol = "W>" 
  " let g:syntastic_auto_jump = 0  
  " let g:syntastic_always_populate_loc_list = 1
  " let g:syntastic_auto_loc_list = 0
  " let g:syntastic_check_on_open = 1
  " let g:syntastic_check_on_wq = 0
endfunction

function! s:PostSetupSyntastic()
  "no-op
endfunction

if has_key(g:plugs, 'syntastic')
  call s:PreSetupSyntastic()
endif

call s:on_load('syntastic', 'call s:PostSetupSyntastic()')
" }}}

" ale {{{
function! s:PreSetupAle()
  " let g:ale_lint_on_text_changed='never'
  " XXX: Ignore plugin incompatibility warnings.
  let g:ale_emit_conflict_warnings = 0
endfunction

function! s:PostSetupAle()

  " TODO: Rewrite neomake functionality in ale?
  " call ale#linter#Define('tex', {
  " \   'name': 'rubberinfo',
  " \   'executable': 'rubber-info',
  " \   'command': 'rubber-info %t',
  " \   'callback': 'ale#handlers#unix#HandleAsWarning'
  " \})

endfunction

if has_key(g:plugs, 'ale')
  call s:PreSetupAle()
endif

call s:on_load('ale', 'call s:PostSetupAle()')
" }}}

" Nvim-R {{{
function! s:PreSetupNvimR()
  " don't select the first option that pops up.
  let g:R_user_maps_only = 1   
  let g:R_insert_mode_cmds = 0 
  let g:R_assign = 0
  let g:R_pdfviewer = "qpdfview"
  let g:R_source_args = 'local=TRUE, print.eval=TRUE'

endfunction

function! s:PostSetupNvimR()

  " FIXME: nvim-plugin needs these before it creates maps; otherwise
  " it won't create the endpoint <Plug>'s.  we're gonna force it to 
  " load them now, but this isn't really an extensible approach.
  vmap <buffer> <LocalLeader>th <Plug>RHelp
  nmap <buffer> <LocalLeader>th <Plug>RHelp
   
  vmap <buffer> <LocalLeader>to <Plug>RObjectStr
  nmap <buffer> <LocalLeader>to <Plug>RObjectStr

  vmap <buffer> <LocalLeader>ts <Plug>RESendSelection
  nmap <buffer> <LocalLeader>tl <Plug>RSendLine
  nmap <buffer> <LocalLeader>tc <Plug>RSendChunk
  nmap <buffer> <LocalLeader>tC <Plug>RSendChunkFH

  nmap <buffer> <LocalLeader>gn <Plug>RNextRChunk
  nmap <buffer> <LocalLeader>gN <Plug>RPreviousRChunk

  nmap <buffer> <LocalLeader>tr <Plug>RStart
  vmap <buffer> <LocalLeader>tr <Plug>RStart
  nmap <buffer> <LocalLeader>tq <Plug>RClose
  vmap <buffer> <LocalLeader>tq <Plug>RClose

  nmap <buffer> <LocalLeader>tk <Plug>RKnit
  vmap <buffer> <LocalLeader>tk <Plug>RKnit

  nmap <buffer> <LocalLeader>tm <Plug>RMakeRmd
  vmap <buffer> <LocalLeader>tm <Plug>RMakeRmd

  nmap <buffer> <LocalLeader>tk <Plug>RKnit
  vmap <buffer> <LocalLeader>tk <Plug>RKnit

  nmap <buffer> <LocalLeader>tm <Plug>RMakePDFK
  vmap <buffer> <LocalLeader>tm <Plug>RMakePDFK

endfunction

if has_key(g:plugs, 'Nvim-R')
  call s:PreSetupNvimR()
endif

call s:on_load('Nvim-R', 'call s:PostSetupNvimR()')
" }}}

" Noweb {{{
" rmd/noweb chunk highlighting and folding
function! s:PreSetupNoweb()
  let noweb_fold_code = 1
endfunction

function! s:PostSetupNoweb()
  "no-op
endfunction

if has_key(g:plugs, 'Noweb')
  call s:PreSetupNoweb()
endif

call s:on_load('Noweb', 'call s:PostSetupNoweb()')
" }}}

" NERDCommenter {{{
function! s:PreSetupNERDCommenter()
  let g:NERDAllowAnyVisualDelims=1
  let g:NERDCommentWholeLinesInVMode=1
  let g:NERDRemoveAltComs=1
  let g:NERDRemoveExtraSpaces=1
  let g:NERDDefaultNesting=1
endfunction

function! s:PostSetupNERDCommenter()
  "no-op
endfunction

if has_key(g:plugs, 'NERDCommenter')
  call s:PreSetupNERDCommenter()
endif

" call s:on_load('NERDCommenter', 'call s:PostSetupNERDCommenter()')
" }}}

" YouCompleteMe {{{
function! s:PreSetupYouCompleteMe()
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
  let g:ycm_auto_trigger=0
  let g:ycm_key_invoke_completion = '<C-space>'
  let g:ycm_key_list_select_completion = ['<C-tab>', '<down>']
  let g:ycm_key_list_select_previous_completion = ['<C-s-tab>', '<up>']
endfunction

function! s:PostSetupYouCompleteMe()
  "no-op
endfunction

if has_key(g:plugs, 'YouCompleteMe')
  call s:PreSetupYouCompleteMe()
endif

call s:on_load('YouCompleteMe', 'call s:PostSetupYouCompleteMe()')
" }}}

" jedi {{{
function! s:PreSetupJedi()
  " XXX: This sets `omnifunc` 
  let g:jedi#auto_initialization = 0
  let g:jedi#auto_vim_configuration = 0

  let g:jedi#completions_enabled = 0
  let g:jedi#use_tabs_not_buffers = 0

  let g:jedi#rename_command = '<localleader>gR'
  let g:jedi#usages_command = '<localleader>gu'
  "let g:jedi#documentation_command = "K"
  "let g:jedi#goto_command = "<localleader>gd"
  "let g:jedi#goto_assignments_command = "<leader>g"
  "let g:jedi#goto_definitions_command = ""
  "let g:jedi#usages_command = "<leader>n"
  "let g:jedi#completions_command = "<C-N>"
  "let g:jedi#rename_command = "<leader>r"

  let g:jedi#smart_auto_mappings = 1
  let g:jedi#auto_close_doc = 1
  "let g:jedi#use_splits_not_buffers = "left"
  let g:jedi#popup_on_dot = 0
  "let g:jedi#popup_select_first = 0
  let g:jedi#show_call_signatures = 0

  augroup jedi_settings
    autocmd!
    " XXX FIXME: Broken for first file loaded.
    " autocmd BufNewFile,BufRead * if &ft == "python" | nmap <buffer> <localleader>gd :<C-u>call jedi#goto()<CR>zv | endif
    autocmd FileType python nmap <buffer> <localleader>gd :<C-u>call jedi#goto()<CR>zv
    " autocmd FileType python nmap <buffer> <localleader>gd :<C-u>call jedi#goto() | normal zv
    autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
  augroup END
endfunction

function! s:PostSetupJedi()
  "no-op
endfunction

if has_key(g:plugs, 'jedi-vim')
  call s:PreSetupJedi()
endif

call s:on_load('jedi-vim', 'call s:PostSetupJedi()')
" }}}

" Ultisnips {{{
function! s:PreSetupUltisnips()
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<C-j>"
  let g:UltiSnipsJumpBackwardTrigger="<C-k>"
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsListSnippets="<F3>"
endfunction

function! s:PostSetupUltisnips()
  "no-op
endfunction

if has_key(g:plugs, 'ultisnips')
  call s:PreSetupUltisnips()
endif

call s:on_load('ultisnips', 'call s:PostSetupUltisnips()')
" }}}

" Airline {{{
function! s:PreSetupAirline()
  let g:airline#extensions#branch#enabled = 1
  "let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tmuxline#enabled = 1
  let g:airline#extensions#syntastic#enabled = 1
  let g:airline#extensions#virtualenv#enabled = 1 
endfunction

function! s:PostSetupAirline()
  "no-op
endfunction

if has_key(g:plugs, 'vim-airline')
  call s:PreSetupAirline()
endif

call s:on_load('vim-airline', 'call s:PostSetupAirline()')
" }}}

" Eclim {{{
function! s:PreSetupEclim()
  let g:EclimMakeLCD=1
  let g:EclimDtdValidate=0
  "setl cot-=preview

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
endfunction

function! s:PostSetupEclim()
  "no-op
endfunction

if has_key(g:plugs, 'eclim')
  call s:PreSetupEclim()
endif

call s:on_load('eclim', 'call s:PostSetupEclim()')
" }}}

" NetrwPlugin {{{
"
" netrw settings
"
" Default to tree mode
let g:netrw_liststyle=3

" Change directory to the current buffer when opening files.
" setl autochdir

let g:netrw_list_hide= '.*\.swp$,.*\.swp\s,.*/$,.*/\s'

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" }}}

" pandoc {{{
function! s:PreSetupPandoc()
  let g:pandoc#modules#disabled = ['chdir']
  let g:pandoc#syntax#conceal#use = 0
endfunction

function! s:PostSetupPandoc()
  "no-op
endfunction

if has_key(g:plugs, 'pandoc')
  call s:PreSetupPandoc()
endif

call s:on_load('pandoc', 'call s:PostSetupPandoc()')
" }}}

" vim-notes {{{
function! s:PreSetupVimnotes()
  let g:notes_directories = ['~/projects/notes']
  let g:notes_markdown_program = 'pandoc' "'pandoc -f markdown_github -t html'
  let g:notes_conceal_code = 0
  let g:notes_suffix = '.vmd'
endfunction

function! s:PostSetupVimnotes()
  "no-op
endfunction

if has_key(g:plugs, 'vim-notes')
  call s:PreSetupVimnotes()
endif

call s:on_load('vim-notes', 'call s:PostSetupVimnotes()')
" }}}

" tmux_navigator {{{
function! s:PreSetupTmuxnavigator()
  let g:tmux_navigator_no_mappings = 1
endfunction

function! s:PostSetupTmuxnavigator()
  silent! nunmap <C-h>
  silent! nunmap <C-j>
  silent! nunmap <C-k>
  silent! nunmap <C-l>

  nnoremap <silent> <C-W>h :TmuxNavigateLeft<cr>
  nnoremap <silent> <C-W>j :TmuxNavigateDown<cr>
  nnoremap <silent> <C-W>k :TmuxNavigateUp<cr>
  nnoremap <silent> <C-W>l :TmuxNavigateRight<cr>
  nnoremap <silent> <C-W>\ :TmuxNavigatePrevious<cr>
endfunction

if has_key(g:plugs, 'tmux-navigator')
  call s:PreSetupTmuxnavigator()
endif

call s:on_load('tmux-navigator', 'call s:PostSetupTmuxnavigator()')
" }}}

" easymotion {{{
function! s:PreSetupEasymotion()
  "no-op
endfunction

function! s:PostSetupEasymotion()
  " These `n` & `N` mappings are optional. You do not have to map `n` & `N` to EasyMotion.
  " Without these mappings, `n` & `N` works fine. (These mappings just provide
  " different highlight method and have some other features )
  "map  n <Plug>(easymotion-next)
  "map  N <Plug>(easymotion-prev)
  map / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)
endfunction

if has_key(g:plugs, 'vim-easymotion')
  call s:PreSetupEasyMotion()
endif

call s:on_load('vim-easymotion', 'call s:PostSetupEasymotion()')
" }}}

" vim-sneak {{{
function! s:PreSetupVimSneak()
  let g:sneak#label = 1
endfunction

function! s:PostSetupVimSneak()
  "no-op
endfunction

if has_key(g:plugs, 'vim-sneak')
  call s:PreSetupVimSneak()
endif

call s:on_load('vim-sneak', 'call s:PostSetupVimSneak()')
" }}}

" riv {{{
function! s:PreSetupRiv()
  let g:riv_python_rst_hl=1
  let g:vim_markdown_math = 1
  let g:vim_markdown_frontmatter = 1
endfunction

function! s:PostSetupRiv()
  "no-op
endfunction

if has_key(g:plugs, 'riv.vim')
  call s:PreSetupRiv()
endif

call s:on_load('riv.vim', 'call s:PostSetupRiv()')
" }}}

" vim-grammarous {{{
function! s:PreSetupGrammarous()
  " https://stackoverflow.com/questions/43574426/how-to-resolve-java-lang-noclassdeffounderror-javax-xml-bind-jaxbexception-in-j
  " let g:grammarous#java_cmd = "java --add-modules java.se.ee"
  let g:grammarous#use_vim_spelllang = 0
  let g:grammarous#enable_spell_check = 1
endfunction

function! s:PostSetupGrammarous()
  "no-op
endfunction

if has_key(g:plugs, 'vim-grammarous')
  call s:PreSetupGrammarous()
endif

call s:on_load('vim-grammarous', 'call s:PostSetupGrammarous()')
" }}}

" vim-projectionist {{{

function! s:PreSetupProjectionist()
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
  function! s:proj_activate() abort
    for [root, value] in projectionist#query('let')
      for [var_name, var_val] in items(value)
        call xolox#misc#msg#debug(printf('proj_activate: %s, %s', var_name, string(var_val)))
        let l:Rval = var_val
        " XXX: Can't use projectionist#query if we want to evaluate functions,
        " since it attempts to resolve placeholders (e.g. '{var}').
        " Use a modified version if you must do this.
        
        " if type(l:Rval) == v:t_func
        "   let l:Rval = var_val()
        " endif
        " call xolox#misc#msg#debug('proj_activate: ' . string(l:Rval))
        
        let {var_name} = l:Rval

      endfor
      break
    endfor
  endfunction

  augroup projectionist_vimrc
    autocmd!
    autocmd User ProjectionistActivate call s:proj_activate()
  augroup END

  let g:projectionist_heuristics = {}

  let g:latex_project_let_vars = { 
        \   'b:latex_figures_dir': '{project}/figures',
        \   'b:latex_src_dir': '{project}/tex',
        \   'b:latex_build_dir': '{project}/output',
        \   'b:latex_pdf_file': '{project}/output/{basename}.pdf',
        \ }

  if has_key(g:plugs, 'vimtex')
    " XXX: Lame that this is a global variable.
    let g:latex_project_let_vars['g:vimtex_latexmk_build_dir'] = '{project}/output'
  endif

  " FYI: `g:projectionist_heuristics` are set in after/ftplugins. 

endfunction

function! s:PostSetupProjectionist()
  "noop
endfunction

if has_key(g:plugs, 'vim-projectionist')
  call s:PreSetupProjectionist()
endif

call s:on_load('vim-projectionist', 'call s:PostSetupProjectionist()')
" }}}

" pgsql.vim {{{
function! s:PreSetupPgsqlVim()
  let g:pgsql_pl = ['python', 'javascript']
endfunction

function! s:PostSetupPgsqlVim()
 "no-op
endfunction

if has_key(g:plugs, 'pgsql.vim')
  call s:PreSetupPgsqlVim()
endif

call s:on_load('pgsql.vim', 'call s:PostSetupPgsqlVim()')
" }}}

" editorconfig-vim {{{

function! s:PreSetupEditorconfig()
  let g:EditorConfig_verbose = 0

  function! CmdlineHook(config)
    " echom string(a:config)
    for [key, value] in items(a:config)
      if key =~ 'cmdline_jupyter'
        let b:{key} = value
      endif
    endfor

    return 0   
  endfunction

  call editorconfig#AddNewHook(function('CmdlineHook'))
endfunction

function! s:PostSetupEditorconfig()
  "no-op
endfunction

if has_key(g:plugs, 'editorconfig-vim')
  call s:PreSetupEditorconfig()
endif

call s:on_load('editorconfig-vim', 'call s:PostSetupEditorconfig()')
" }}}

" LanguageClient-neovim {{{
function! s:PreSetupLanguageClient()

  let g:LanguageClient_serverCommands = {
        \ 'cpp': ['/home/bwillard/apps/clangd/bin/clangd'],
        \ 'c': ['/home/bwillard/apps/clangd/bin/clangd'],
        \ 'python': ['/home/bwillard/apps/anaconda3/envs/neovim3/bin/pyls']
        \ }
        " \ 'python': ['/home/bwillard/.pyenv/shims/pyls']
  let g:LanguageClient_autoStart = 1
  " let g:LanguageClient_trace = 'verbose'
  
endfunction

function! s:PostSetupLanguageClient()

  function! s:LocalLanguageClientSettings()
    if index(keys(get(g:, 'LanguageClient_serverCommands', {})), &filetype) > 0 
      nnoremap <silent><buffer> <localleader>K :call LanguageClient_textDocument_hover()<CR>
      nnoremap <silent><buffer> <localleader>gd :call LanguageClient_textDocument_definition()<CR>
      nnoremap <silent><buffer> <localleader>R :call LanguageClient_textDocument_rename()<CR>
      nnoremap <silent><buffer> <localleader>gS :call LanguageClient_textDocument_documentSymbol()<CR>
      nnoremap <silent><buffer> <localleader>gr :call LanguageClient_textDocument_references()<CR>
      nnoremap <silent><buffer> <localleader>gF :call LanguageClient_textDocument_formatting()<CR>
      setlocal formatexpr=LanguageClient_textDocument_rangeFormatting() |
      setlocal omnifunc=LanguageClient#complete
    endif
  endfunction

  " To send test messages to a server:
  " :call LanguageClient_notify(method, params) 
  " E.g.
  " :call LanguageClient_notify('workspace/didChangeConfiguration', {'settings': 'blah'}) 
  " See https://github.com/Microsoft/language-server-protocol/blob/master/protocol.md

  augroup languageclient
    autocmd!
    " TODO: Check that formatting is supported by the language?
    autocmd User LanguageClientStarted call s:LocalLanguageClientSettings()
    " setl completefunc=LanguageClient#complete
  augroup END

endfunction

if has_key(g:plugs, 'LanguageClient-neovim')
  call s:PreSetupLanguageClient()
endif

call s:on_load('LanguageClient-neovim', 'call s:PostSetupLanguageClient()')
"}}}

" fzf.vim {{{
function! s:PreSetupFzfVim()
  let g:fzf_command_prefix = 'Fzf'

  function! s:build_quickfix_list(lines)
    echom a:lines
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

  let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

endfunction

function! s:PostSetupFzfVim()
  " Add filename completion to :Ag
  "

  command! -bang -nargs=+ -complete=dir Ag call fzf#vim#ag_raw(<q-args>, <bang>0)
endfunction

if has_key(g:plugs, 'fzf.vim')
  call s:PreSetupFzfVim()
endif

call s:on_load('fzf.vim', 'call s:PostSetupFzfVim()')
" }}}

" deoplete-clang {{{
function! s:PreSetupDeopleteClang()

  let g:deoplete#sources#clang#libclang_path='/usr/lib/x86_64-linux-gnu/libclang-4.0.so.1'
  let g:deoplete#sources#clang#clang_header='/usr/include/clang/4.0/include'

  let g:clang_complete_auto = 0
  let g:clang_auto_select = 0
  let g:clang_omnicppcomplete_compliance = 0
  let g:clang_make_default_keymappings = 0
endfunction

function! s:PostSetupDeopleteClang()
  "no-op
endfunction

if has_key(g:plugs, 'deoplete-clang')
  call s:PreSetupDeopleteClang()
endif

call s:on_load('deoplete-clang', 'call s:PostSetupDeopleteClang()')
" }}}

" vim:foldmethod=marker:ts=2:sts=2:sw=2

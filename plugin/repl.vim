
"
" Here we define some variables that will be used
" by a REPL subsytem.  Most/all of these variables
" are buffer local.
"
" Partially inspired by: 
" https://github.com/tarruda/neovim/blob/95242bba133d3bee1937238ba0aeb0f048d4a0e3/contrib/neovim_gdb/neovim_gdb.vim
"
"
 
if exists("b:loaded_repl")
  finish
endif

let b:loaded_repl = 1

let s:save_cpo = &cpo
set cpo&vim


" REPL variables {{{
let b:repl_run_command = "" 
let b:repl_debug_command = ""
" }}}

" REPL function stubs {{{
function! ReplSendString_na(...)
  throw "no function registered"
  return 0
endfunction

function! ReplSendFormat_na(...)
  throw "no function registered"
  return 0
endfunction

function! ReplSpawnTerm_na(...)
  throw "no function registered"
  return 0
endfunction

function! ReplCloseTerm_na(...)
  throw "no function registered"
  return 0
endfunction

function! ReplSendFile_na(...)
  throw "no function registered"
  return 0
endfunction

let b:ReplSendString = function('ReplSendString_na') 
" This function pre-formats a string of commands before it is sent
" to the REPL destination.
let b:ReplSendFormat = function('ReplSendFormat_na') 
let b:ReplSpawnTerm = function('ReplSpawnTerm_na') 
let b:ReplCloseTerm = function('ReplCloseTerm_na') 
let b:ReplSendFile = function('ReplSendFile_na') 

" }}}

" REPL default functions {{{

"if !exists("*s:ReplGetSelection")
function! s:ReplGetSelection(curmode) range
  "
  " This function gets either the visually selected text,
  " or the current <cWORD>.
  "
  if (a:firstline == 1 && a:lastline == line('$')) || a:curmode == "n"
    return expand('<cWORD>')
  endif
  let [lnum1, col1] = getpos("'<")[1:2]
  let end_pos = getpos("'>")
  let [lnum2, col2] = end_pos[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][:col2 - 1]
  let lines[0] = lines[0][col1 - 1:]
  " Sends the cursor to the beginning of the last visual select
  " line.  We probably want to leave the cursor at the end of the
  " visually selected region instead.
  "call cursor(lnum2, 1)
  execute "normal! gv\<Esc>"
  return join(lines, "\n")
endfunction

function! s:ReplSendLines(in_lines)
  "
  " Send lines (individually) to the terminal.
  "
  let lines = copy(a:in_lines)
  call filter(lines, '!empty(v:val) && v:val !~ ''^\s*$''')
  if empty(lines)
    return
  endif
  let last_n_ind = 0
  let start_n_ind = len(matchstr(lines[0], '^\(\s\)*'))
  for i in range(0, len(lines)-1)
    let line = lines[i]

    " track indents for python
    let n_ind = len(matchstr(lines[i], '^\(\s\)*'))
    if n_ind < last_n_ind
      call b:ReplSendKey("Enter")
    endif
    let last_n_ind = n_ind  

    call b:ReplSendString(escape(line, '`\'))
    call b:ReplSendString("Enter")
  endfor

  " just in case the lines ended at the end
  " of a function declaration
  if last_n_ind > start_n_ind
    call b:ReplSendString("Enter")
  endif
endfunction

" }}}

" REPL default mappings and commands {{{

command! ReplSendFileCmd call b:ReplSendFile() 
"command! ReplSendLineCmd call b:ReplSendString(escape(getline("."), '`\')) 
command! ReplSendLineCmd call b:ReplSendString(getline(".")) 
command! -range -nargs=1 ReplSendStringCmd call b:ReplSendString(<f-args>) 
command! -range -nargs=1 ReplSendSelectionCmd call b:ReplSendString(s:ReplGetSelection(<f-args>)) 
command! ReplCloseTermCmd :call b:ReplCloseTerm() 
"command! -nargs=1 ReplSpawnTermCmd :call b:ReplSpawnTerm(<f-args>) 
command! ReplSpawnTermCmd :call b:ReplSpawnTerm(b:repl_run_command) 
command! ReplSpawnTermDebugCmd :call b:ReplSpawnTerm(b:repl_debug_command) 

" }}}

if has("nvim")

  " Nvim REPL implementations {{{
  if !exists("*s:ReplCleanTerm_nvim")
    function s:ReplCleanTerm_nvim()
      if exists("t:repl_term_id")
        unlet t:repl_term_id 
      endif
      if exists("t:repl_buf_id")
        unlet t:repl_buf_id 
      endif
    endfunction
  endif

  function! ReplSpawnTerm_nvim(expr)
    if exists('t:repl_term_id')
      throw 'Already running a repl terminal'
    endif
    "sb
    split
    wincmd j
    enew | let t:repl_term_id = termopen(a:expr, {"on_exit": "s:ReplCleanTerm_nvim"}) 
    if t:repl_term_id < 1
      exec 'bd! '.bufnr('%')
      throw 'termopen failed'
    endif
    let t:repl_buf_id = bufnr('%')
    set nobuflisted
    wincmd p
  endfunction

  function! ReplCloseTerm_nvim()
    if !exists('t:repl_term_id')
      throw 'No running repl terminal'
    endif
    call jobsend(t:repl_term_id, "\<c-d>y\<cr>")
    call jobstop(t:repl_term_id)
    exec 'bd! '.t:repl_buf_id
  endfunction

  function! ReplSendString_nvim(expr)
    if !exists('t:repl_term_id')
      throw 'No running repl terminal'
    endif
    let formatted_expr = b:ReplSendFormat(a:expr)
    call jobsend(t:repl_term_id, formatted_expr)
  endfunction

  function! ReplSendFormat_nvim(expr)
    let comb_expr = a:expr
    if type(a:expr) == 3
      let comb_expr = join(a:expr, "\n") 
    endif
    return xolox#misc#str#dedent(comb_expr)
  endfunction

  function! ReplSendFile_nvim()
    if !exists('t:repl_term_id')
      throw 'No running repl terminal'
    endif
    call jobsend(t:repl_term_id, "%run ".expand("%")."\<cr>")
  endfunction

  let b:ReplSpawnTerm = function('ReplSpawnTerm_nvim') 
  let b:ReplCloseTerm = function('ReplCloseTerm_nvim') 
  let b:ReplSendString = function('ReplSendString_nvim') 
  let b:ReplSendFile = function('ReplSendFile_nvim') 
  let b:ReplSendFormat = function('ReplSendFormat_nvim') 

  " }}}
    

else 

  "
  " Setup Vimux for specific interactive sessions
  " TODO: need to finish this...
  "
  " Vimux REPL implementations {{{

  function! ReplSendString_vimux(a:expr)
    call VimuxSendText(escape(a:expr,'`\'))
  endfunction

  function! ReplCleanTerm_vimux(...)
    throw "no repl function registered"
    return 0
  endfunction

  function! ReplSpawnTerm_vimux(a:expr)
    call VimuxRunCommand(a:expr)
  endfunction

  function! ReplCloseTerm_vimux(...)
    throw "no repl function registered"
    return 0
  endfunction

  function! ReplSendFileTerm_vimux(...)
    throw "no repl function registered"
    return 0
  endfunction

  "function! VimuxSlime()
  "  call VimuxSendText(escape(@z,'`\'))
  "  call VimuxSendKeys("Enter")
  "endfunction

  "function! VimuxBufferStart()
  "  if exists("g:vimux_run_command")
  "    call VimuxRunCommand(g:vimux_run_command)
  "  else
  "    call VimuxOpenPane()
  "  endif
  "endfunction

  "" send visual selection
  "if empty(mapcheck("<LocalLeader>ts"))
  "  vmap <LocalLeader>ts "zy :call VimuxSlime()<CR>  
  "endif

  "" send line
  "if empty(mapcheck("<LocalLeader>tl"))
  "  map <LocalLeader>tl "zY :call VimuxSlime()<CR>  
  "endif

  "" send/print word
  "if empty(mapcheck("<LocalLeader>tp"))
  "  nmap <LocalLeader>tp "zyiw :call VimuxSlime()<CR>  
  "endif

  "" general run/open and quit/close
  "if empty(mapcheck("<LocalLeader>tr"))
  "  nnoremap <LocalLeader>tr :call VimuxBufferStart()<CR>  
  "endif

  "if empty(mapcheck("<LocalLeader>tq"))
  "  nnoremap <LocalLeader>tq :VimuxCloseRunner<CR>
  "endif

  " }}}


endif


let &cpo = s:save_cpo

" vim:foldmethod=marker:foldlevel=0

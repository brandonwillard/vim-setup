
setl tabstop=4
setl expandtab
setl shiftwidth=2
setl softtabstop=2
"setl foldmethod=indent
"setl foldnestmax=2
setl iskeyword+=_
setl autoindent
setl conceallevel=0

" remove nocorrect if you're not using zshell (it stops the input
" requirement when/if ipython doesn't exist)
let s:ipython_run_command = "nocorrect ipython --matplotlib \|\| python"
let s:ipython_debug_command = "nocorrect ipython --pydb --matplotlib \|\| python"
"let s:ipython_run_command = "nocorrect jupyter console \|\| python"
"let s:ipython_debug_command = "nocorrect jupyter console --InteractiveShell.pdb=True --ZMQTerminalInteractiveShell.image_handler=PIL \|\| python"

if has("nvim")

  if exists("g:evim_ipython_repl_loaded")
    finish
  endif

  let g:evim_ipython_repl_loaded = 1
  "
  " inspired by: 
  " https://github.com/tarruda/neovim/blob/95242bba133d3bee1937238ba0aeb0f048d4a0e3/contrib/neovim_gdb/neovim_gdb.vim
  "
  function! s:CleanIPythonTerm()
    if exists("t:ipython_term_id")
      unlet t:ipython_term_id 
    endif
    if exists("t:ipython_buf_id")
      unlet t:ipython_buf_id 
    endif
  endfunction

  function! s:SpawnIPythonTerm(expr)
    "if exists('t:ipython_term_id')
    "  throw 'Already running an IPython terminal'
    "endif
    "sb
    split
    wincmd j
    enew | let t:ipython_term_id = termopen(a:expr, {"on_exit":"s:CleanIPythonTerm"}) 
    let t:ipython_buf_id = bufnr('%')
    set nobuflisted
    wincmd p
  endfunction

  function! s:CloseIPythonTerm()
    if !exists('t:ipython_term_id')
      throw 'No running IPython terminal'
    endif
    call jobsend(t:ipython_term_id, "\<c-d>y\<cr>")
    exec 'bd! '.t:ipython_buf_id
  endfunction

  function! s:EvalIPythonTerm(expr)
    if !exists('t:ipython_term_id')
      throw 'No running IPython terminal'
    endif
    call jobsend(t:ipython_term_id, "%cpaste\<cr>".a:expr."\<cr>\<c-d>")
  endfunction

  function! s:RunFileIPythonTerm()
    if !exists('t:ipython_term_id')
      throw 'No running IPython terminal'
    endif
    call jobsend(t:ipython_term_id, "%run ".expand("%")."\<cr>")
  endfunction

  function! s:GetExpression(curmode) range
    if (a:firstline == 1 && a:lastline == line('$')) || a:curmode == "n"
      return expand('<cWORD>')
    endif
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][:col2 - 1]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
  endfunction

  command! RunFileIPythonCmd call s:RunFileIPythonTerm() 
  command! EvalLineIPythonCmd call s:EvalIPythonTerm(escape(getline("."), '`\')) 
  command! -range -nargs=1 EvalIPythonCmd call s:EvalIPythonTerm(s:GetExpression(<f-args>)) 
  command! CloseIPythonTermCmd :call s:CloseIPythonTerm() 
  "command! -nargs=1 SpawnIPythonTermCmd :call s:SpawnIPythonTerm(<f-args>) 
  command! SpawnIPythonTermCmd :call s:SpawnIPythonTerm(s:ipython_run_command) 
  command! SpawnIPythonTermDebugCmd :call s:SpawnIPythonTerm(s:ipython_debug_command) 

  nnoremap <silent> <LocalLeader>tr :SpawnIPythonTermCmd<CR>
  nnoremap <silent> <LocalLeader>td :SpawnIPythonTermDebugCmd<CR>
  nnoremap <silent> <LocalLeader>tq :CloseIPythonTermCmd<CR>
  nnoremap <silent> <LocalLeader>ts :EvalIPythonCmd n<CR>
  vnoremap <silent> <LocalLeader>ts :EvalIPythonCmd v<CR>
  nnoremap <silent> <LocalLeader>tl :EvalLineIPythonCmd<CR>
  nnoremap <silent> <LocalLeader>tf :RunFileIPythonCmd<CR>

else 

  "
  " Setup Vimux for specific interactive sessions
  "
  function! SourceLines(in_lines)
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
        call VimuxSendKeys("Enter")
      endif
      let last_n_ind = n_ind  

      "call VimuxSendText(escape(line, "`") . "\<C-M>")
      call VimuxSendText(escape(line, '`\'))
      call VimuxSendKeys("Enter")
    endfor

    " just in case the lines ended at the end
    " of a function declaration
    if last_n_ind > start_n_ind
      call VimuxSendKeys("Enter")
    endif
  endfunction

  nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand(s:ipython_run_command)<CR>

  " provide a start for debug mode
  if empty(mapcheck("<LocalLeader>td"))
    nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand(s:ipython_debug_command)<CR>
  endif

endif



"setl tabstop=4
"setl softtabstop=4
"setl shiftwidth=4
"setl expandtab
setl iskeyword+=_

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

" remove nocorrect if you're not using zshell (it stops the input
" requirement when/if ipython doesn't exist)
let g:vimux_run_command = "nocorrect ipython --matplotlib \|\| python"

" provide a start for debug mode
if empty(mapcheck("<LocalLeader>rc"))
  nnoremap <buffer> <LocalLeader>rc :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR> 
else
  nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR> 
endif



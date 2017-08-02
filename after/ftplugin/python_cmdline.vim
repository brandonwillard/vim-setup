
function! s:StartJupyterString()
  let python_version = system('python -V')
  " Remove nocorrect if you're not using zshell (it stops the input
  if python_version =~ '^Python 3\.\?'
    if get(g:, "cmdline_jupyter", 0)
      return "nocorrect jupyter-console --kernel python3 \|\| python"
    else
      return "nocorrect ipython3 \|\| python"
    endif
  elseif python_version =~ '^Python 2\.\?'
    if get(g:, "cmdline_jupyter", 0)
      return "nocorrect jupyter-console --kernel python2 \|\| python"
    else
      return "nocorrect ipython2 \|\| python"
    endif 
  else
    if get(g:, "cmdline_jupyter", 0)
      return "nocorrect jupyter-console \|\| python"
    else
      return "nocorrect ipython \|\| python"
    endif 
  endif
endfunction

if executable("jupyter-console")
  " if exists("g:cmdline_app")
  "   let g:cmdline_app["python"] = s:StartJupyterString()
  " else
  "   let g:cmdline_app = {"python": s:StartJupyterString()}
  " endif
  let b:cmdline_app = s:StartJupyterString()
else
  let b:cmdline_app = "python"
endif

let b:cmdline_quit_cmd = "quit()"
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "python"

command! -buffer PythonSendIPythonDebugLine :call b:cmdline_source_fun('%debug -b ' . expand('%') . ':' . line('.'))


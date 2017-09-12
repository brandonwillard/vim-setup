
function! MaybeJupyter()

  let python_version = system('python -V')

  if python_version =~ '^Python 3\.\?'
    let python_version = "3"
  elseif python_version =~ '^Python 2\.\?'
    let python_version = "2"
  else
    let python_version = ""
  endif

  let cmdline_jupyter_kernel = printf("python%s", python_version)

  let cmdline_app = ""
  if get(b:, "cmdline_jupyter", get(g:, "cmdline_jupyter", 0))
    let cmdline_app = g:StartJupyterString(cmdline_jupyter_kernel)
  endif

  if cmdline_app == ""
    if executable("i" . cmdline_jupyter_kernel)
      let cmdline_app = "i" . cmdline_jupyter_kernel
    else
      let cmdline_app = cmdline_jupyter_kernel
    endif
  endif

  return cmdline_app
endfunction

let b:cmdline_app = function("MaybeJupyter")
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "python"

command! -buffer PythonSendIPythonDebugLine :call b:cmdline_source_fun('%debug -b ' . expand('%') . ':' . line('.'))

" vim:foldmethod=marker:foldlevel=0:ts=2:sts=2:sw=2

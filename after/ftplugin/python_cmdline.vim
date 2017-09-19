
""
" Construct a string for starting a Jupyter or IPython kernel.
" @setting b:/g:cmdline_jupyter
" Prefer a Jupyter kernel if one can be constructed; otherwise, 
" an IPython one (if the executable exists).
"
function! MaybeJupyter()

  let l:cmdline_jupyter_kernel = GetPythonVersion()

  let l:cmdline_app = ''
  if get(b:, 'cmdline_jupyter', get(g:, 'cmdline_jupyter', 0))
    let l:cmdline_app = g:StartJupyterString(l:cmdline_jupyter_kernel)
  endif

  if l:cmdline_app ==# ''
    if executable('i' . l:cmdline_jupyter_kernel)
      let l:cmdline_app = 'i' . l:cmdline_jupyter_kernel
    else
      let l:cmdline_app = l:cmdline_jupyter_kernel
    endif
  endif

  return l:cmdline_app
endfunction

let b:cmdline_app = function('MaybeJupyter')
let b:cmdline_quit_cmd = 'quit()'
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}
let b:cmdline_send_empty = 0
let b:cmdline_filetype = 'python'

command! -buffer PythonSendIPythonDebugLine :call b:cmdline_source_fun('%debug -b ' . expand('%') . ':' . line('.'))

" vim:foldmethod=marker:foldlevel=0:ts=2:sts=2:sw=2



setl iskeyword+=_
setl iskeyword-=.
setl conceallevel=0
setl textwidth=79
setl cino+=(0
setl formatprg=autopep8\ -a\ -
" Can't get this to work, yet.  Looks like the shell script
" doesn't really handle stdin pipes.
" Could probably write a wrapper that adds the functionality:
" http://stackoverflow.com/a/11111088/3006474
"setl formatprg=yapf\ -


" Add python paths to vim search (so you can open source files with gf, etc)
" from: http://vim.wikia.com/wiki/VimTip1546 .

if exists("b:loaded_python_after")
  finish
else

  let b:loaded_python_after = 1

python << EOF
import os
import sys
import vim
for p in sys.path:
    # Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

endif

" Only run certain pymode/rope features for pure python files.
" E.g. definition lookup won't work (because it doesn't parse only
" the code chunks, yet).
" if !(exists("b:noweb_backend") || exists("b:noweb_language"))
"   let g:pymode_rope = 1 
" else
"   let g:pymode_rope = 0 
" endif

if !exists("b:loaded_repl")
  runtime! plugin/repl.vim
endif

function! StartJupyterString()
  let python_version = system('python -V')
  " Remove nocorrect if you're not using zshell (it stops the input
  if python_version =~ '^Python 3\.\?'
    return "nocorrect jupyter-console --kernel python3 \|\| python"
  elseif python_version =~ '^Python 2\.\?'
    return "nocorrect jupyter-console --kernel python2 \|\| python"
  else
    return "nocorrect jupyter-console \|\| python"
  endif
endfunction

let b:repl_run_command = StartJupyterString()
let b:repl_debug_command = StartJupyterString()



let b:ReplSendString_default = CopyFuncRef(b:ReplSendString)
let b:ReplSendFormat_default = CopyFuncRef(b:ReplSendFormat)
let b:ReplSendFile_default = CopyFuncRef(b:ReplSendFile)

function! Strip(input_string)
  return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

"function! ReplSendFormat_ipy(expr)
"
"endfunction

function! ReplSendString_ipy(expr)
 
  let expr_str = "\x1b[200~".b:ReplSendFormat_default(a:expr).""
  " let expr_str = b:ReplSendFormat_default(a:expr)

  call b:ReplSendString_default(expr_str)
  call b:ReplSendString_default(["\x1b[201~", "\r", "\n"])

endfunction

" IPython has a handy command that takes care of running files, so we
" use that...
function! ReplSendFile_ipy()
  return b:ReplSendString_default(["%run ".expand("%")])
endfunction

" could just change the maps...
let b:ReplSendString = function("ReplSendString_ipy")
"let b:ReplSendFormat = function('ReplSendFormat_ipy') 
let b:ReplSendFile = function("ReplSendFile_ipy")

command! PythonSendIPythonDebugLine :call b:ReplSendString_default('%debug -b ' . expand('%') . ':' . line('.'))

setl complete+=t
setl define=^\s*\\(def\\\\|class\\)
setl iskeyword+=_
setl iskeyword-=.
setl conceallevel=0
setl shiftwidth=4 
setl tabstop=4
setl softtabstop=4
setl expandtab
setl shiftround
setl cino+=(0
setl cinwords=if,elif,else,for,while,try,except,finally,def,class
setl formatoptions=croqljt
setl formatprg=autopep8\ -a\ -
" Can't get this to work, yet.  Looks like the shell script
" doesn't really handle stdin pipes.
" Could probably write a wrapper that adds the functionality:
" http://stackoverflow.com/a/11111088/3006474
"setl formatprg=yapf\ -

if exists("g:pymode_options_max_line_length")
  exe "setlocal textwidth=" . g:pymode_options_max_line_length
else
  setl textwidth=79
endif

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

function! ReplSendString_ipy(expr)
  " Just for some background, you might see control/escape
  " sequences like `\x1b[200~` printed as `^[[200~`.  The
  " first part is, of course, the ESC control character
  " (ASCII: `^[`).  These exact control sequences are bracketed
  " paste modes in an xterm setting 
  " (see https://cirw.in/blog/bracketed-paste).
  "
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

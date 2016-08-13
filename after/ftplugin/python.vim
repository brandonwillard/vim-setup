

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

if !exists("b:loaded_repl")
  runtime! plugin/repl.vim
endif

" Remove nocorrect if you're not using zshell (it stops the input
" requirement when/if ipython doesn't exist).
let b:repl_run_command = "nocorrect ipython2 --matplotlib \|\| python"
let b:repl_debug_command = "nocorrect ipython2 --pydb --matplotlib \|\| python"

let b:ReplSendString_default = CopyFuncRef(b:ReplSendString)
let b:ReplSendFile_default = CopyFuncRef(b:ReplSendFile)

function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

" IPython has a magic for executing blocks of code; use it.
function! ReplSendString_ipy(expr)
  let lines = copy(split(a:expr, "\n"))
  call filter(lines, '!empty(v:val) && v:val !~ ''^\s*$''')
  if empty(lines)
    return
  endif

  let argv = []
  if len(lines) > 1
    let argv = ["%cpaste"] + lines + ['--', '']
  else
    let argv = lines + ['']
  endif
  call b:ReplSendString_default(argv)

  "call b:ReplSendString_default(["_=get_ipython().run_cell('.substitute(a:expr, "\n", '\\n', '').')",''])
  
  "let last_n_ind = 0
  "let start_n_ind = len(matchstr(lines[0], '^\(\s\)*'))
  "for i in range(0, len(lines)-1)
  "  let line = lines[i]


  "  " track indents for python
  "  let n_ind = len(matchstr(lines[i], '^\(\s\)*'))
  "  if n_ind < last_n_ind
  "    "call b:ReplSendKey("Enter")
  "    call b:ReplSendString_default(["\n\r", ''])
  "  endif
  "  let last_n_ind = n_ind  

  "  "echo "sending ".escape(line, '`\')
  "  call b:ReplSendString_default([escape(line, '`\'), ''])
  "  sleep 100m
  "endfor

  "" just in case the lines ended at the end
  "" of a function declaration
  "if last_n_ind > start_n_ind
  "  call b:ReplSendString_default(["\r", ''])
  "endif
endfunction

" IPython has a handy command that takes care of running files, so we
" use that...
function! ReplSendFile_ipy()
  return b:ReplSendString_default(["%run ".expand("%")])
endfunction

" could just change the maps...
let b:ReplSendString = function("ReplSendString_ipy")
let b:ReplSendFile = function("ReplSendFile_ipy")

command! PythonSendIPythonDebugLine :call b:ReplSendString_default('%debug -b ' . expand('%') . ':' . line('.'))


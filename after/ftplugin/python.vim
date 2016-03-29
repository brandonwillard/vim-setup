
if exists("b:loaded_python_after")
  finish
endif

let b:loaded_python_after = 1


setl iskeyword+=_
setl conceallevel=0
"setl cino=(0
"set cindent


" Add python paths to vim search (so you can open source files with gf, etc)
" from: http://vim.wikia.com/wiki/VimTip1546 .
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

if exists("b:loaded_repl")
  " Remove nocorrect if you're not using zshell (it stops the input
  " requirement when/if ipython doesn't exist).
  let b:repl_run_command = "nocorrect ipython --matplotlib \|\| python"
  let b:repl_debug_command = "nocorrect ipython --pydb --matplotlib \|\| python"

  let b:ReplSendString_default = CopyFuncRef(b:ReplSendString)
  let b:ReplSendFile_default = CopyFuncRef(b:ReplSendFile)

  " IPython has a magic for executing blocks of code; use it.
  function! ReplSendString_ipy(expr)
    let t:argv = "%cpaste\<cr>".a:expr."\<cr>\<c-d>"
    return b:ReplSendString_default(t:argv)
  endfunction

  " IPython has a handy command that takes care of running files, so we
  " use that...
  function! ReplSendFile_ipy()
    return b:ReplSendString_default("%run ".expand("%")."\<cr>")
  endfunction

  " could just change the maps...
  let b:ReplSendString = function("ReplSendString_ipy")
  let b:ReplSendFile = function("ReplSendFile_ipy")
endif




setl iskeyword+=_
setl iskeyword-=.
setl conceallevel=0
"setl cino=(0
"set cindent


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

" IPython has a magic for executing blocks of code; use it.
function! ReplSendString_ipy(expr)
  let argv = ["%cpaste"] + split(a:expr, "\n") + ['--', '']
  call b:ReplSendString_default(argv)
endfunction

" IPython has a handy command that takes care of running files, so we
" use that...
function! ReplSendFile_ipy()
  return b:ReplSendString_default(["%run ".expand("%")])
endfunction

" could just change the maps...
let b:ReplSendString = function("ReplSendString_ipy")
let b:ReplSendFile = function("ReplSendFile_ipy")


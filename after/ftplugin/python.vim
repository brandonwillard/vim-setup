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
setl cinwords=if,elif,else,for,while,try,except,finally,def,class,with
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

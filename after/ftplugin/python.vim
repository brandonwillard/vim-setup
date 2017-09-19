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
setl cinoptions+=(0
setl cinwords=if,elif,else,for,while,try,except,finally,def,class,with
setl formatoptions=croqljt

if exists('g:pymode_options_max_line_length')
  exe 'setlocal textwidth=' . g:pymode_options_max_line_length
else
  setl textwidth=79
endif

if exists('b:loaded_python_after')
  finish
else

  let b:loaded_python_after = 1

python << EOF

#
# Add python paths to vim search (so you can open source files with gf, etc)
# from: http://vim.wikia.com/wiki/VimTip1546 .
#

import os
import sys
import vim

sys_paths = ",".join(filter(os.path.isdir, sys.path))
vim.command("set path+={}".format(sys_paths.replace(" ", r"\ ")))

EOF

endif

" python << EOF
" def has_yapf():
"   import pkgutil
"   return pkgutil.find_loader('yapf') is not None
" EOF

" if pyeval("has_yapf()")

"   function! YAPF() range
"     " Determine range to format.
"     let l:line_ranges = a:firstline . '-' . a:lastline
"     let l:cmd = 'yapf --lines=' . l:line_ranges

"     " Call YAPF with the current buffer
"     let l:formatted_text = system(l:cmd, join(getline(1, '$'), "\n") . "\n")

"     " Update the buffer.
"     execute '1,' . string(line('$')) . 'delete'
"     call setline(1, split(l:formatted_text, "\n"))

"     " Reset cursor to first line of the formatted range.
"     call cursor(a:firstline, 1)
"   endfunction

"   command! -range=% YAPF <line1>,<line2>call YAPF()

"   setl formatexpr=YAPF
" else
"   setl formatprg=autopep8\ -a\ -
" endif

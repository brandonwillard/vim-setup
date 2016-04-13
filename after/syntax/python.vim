
if !exists("b:current_syntax") || b:current_syntax != "python" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

setl iskeyword+=_
setl iskeyword-=.
setl conceallevel=0

let &cpo = s:keepcpo
unlet s:keepcpo
" vim:ts=18  fdm=marker



if !exists("b:current_syntax") || b:current_syntax !~ "tex$" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

setl formatoptions+=croql
setl iskeyword+=_,.,-,:

let &cpo = s:keepcpo
unlet s:keepcpo
" vim:ts=18  fdm=marker

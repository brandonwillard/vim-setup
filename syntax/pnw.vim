
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

runtime syntax/noweb.vim

setl formatoptions+=croql
setl iskeyword+=_

let &cpo = s:keepcpo
unlet s:keepcpo
" vim:ts=18  fdm=marker


if version < 600
  syntax clear
elseif exists("b:current_syntax") && b:current_syntax != "texw" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

let b:noweb_backend="tex"
let b:noweb_language="python"

runtime syntax/noweb.vim

setl iskeyword+=_
setl iskeyword-=.
setl formatoptions+=croql

"let b:current_syntax = "texw"

let &cpo = s:keepcpo
unlet s:keepcpo

" vim:foldmethod=marker:foldlevel=0

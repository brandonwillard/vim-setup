
if version < 600
  syntax clear
elseif exists("b:current_syntax") && b:current_syntax != "texw" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim


" FIXME: questionable...
" clear out old/unecessary syntax
"runtime syntax/nosyntax.vim
:syntax clear
runtime syntax/noweb.vim

setl iskeyword+=_
setl iskeyword-=.
setl formatoptions+=croql

let b:current_syntax = "texw"

let &cpo = s:keepcpo
unlet s:keepcpo
" vim:ts=18  fdm=marker

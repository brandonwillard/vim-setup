
"if exists("b:current_syntax")
"  finish
"endif
"let b:current_syntax = "texw"

" clear out old/unecessary syntax
runtime syntax/nosyntax.vim

runtime syntax/noweb.vim

setl iskeyword+=_
setl iskeyword-=.
setl formatoptions+=croql


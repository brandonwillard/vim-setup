
if !exists("b:current_syntax") || b:current_syntax !~ "tex$" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

" TODO: Again, which file should these settings really be in?
" setl formatoptions+=croql
" setl iskeyword+=_,.,-,:

let &cpo = s:keepcpo
unlet s:keepcpo

" vim:foldmethod=marker:foldlevel=0

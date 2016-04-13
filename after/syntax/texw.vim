
if !exists("b:current_syntax") || b:current_syntax != "texw" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

"execute "syntax include @Code syntax/" . noweb_language . ".vim"
" add support for inline code
syntax match texwEndInline "%>" contained
syntax match texwBeginInline "<%" contained
syntax region texwrInline start="<%" end="%>" contains=@Code,texwBeginInline,texwEndInline keepend


let &cpo = s:keepcpo
unlet s:keepcpo
" vim:ts=18  fdm=marker

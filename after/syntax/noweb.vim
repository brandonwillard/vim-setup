
if !exists("b:current_syntax") || b:current_syntax != "noweb" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim


execute "syntax include @Code syntax/" . noweb_language . ".vim"
" add support for inline code
syntax match nowebEndInline "}" contained
syntax match nowebBeginInline "\Sexpr{" contained
syntax region nowebrInline start="\Sexpr{" end="}" contains=@Code,nowebBeginInline,nowebEndInline keepend


let &cpo = s:keepcpo
unlet s:keepcpo
" vim:ts=18  fdm=marker

" Syntax file for a Python + Markdown Noweb file.
"
" Remarks: 
" Todo: There's still some issue with Python code highlighting in
" code chunks.  Stuff like `r_1` hilights the `1` and matches the
" `pythonNumber` syntax group; regular python files do not (as
" expected).  I thought it might have to do with `_` not being
" recognized as a Vim `keyword`, but haven't confirmed it.
"

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

" noweb syntax file reads these as globals
let b:noweb_backend="markdown"
let b:noweb_language="python"


runtime syntax/noweb.vim

" TODO: Ugh, still haven't decided where these should go.
setl formatoptions+=croql
setl iskeyword+=_

"let b:current_syntax = "pnw"

let &cpo = s:keepcpo
unlet s:keepcpo

" vim:foldmethod=marker:foldlevel=0

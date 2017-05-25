
if !exists("b:current_syntax") || b:current_syntax != "python" 
  finish
endif

let s:keepcpo= &cpo
set cpo&vim

" XXX: These are already set in `after/ftplugin/python.vim`; which file should
" they really be in?
" setl iskeyword+=_
" setl iskeyword-=.
" setl conceallevel=0

let &cpo = s:keepcpo
unlet s:keepcpo

" vim:foldmethod=marker:foldlevel=0

"if exists("current_compiler")
"  finish
"endif
"let current_compiler = "tex"

"if exists(":CompilerSet") != 2
"  command -nargs=* CompilerSet setlocal <args>
"endif

"CompilerSet errorformat&		" use the default 'errorformat'
"CompilerSet makeprg=nmake

unlet! current_compiler
runtime! compiler/latexmk.vim

if filereadable('Makefile')
  exec "setl makeprg=make\\ ".expand("%:r:t").".pdf"
elseif filereadable('latex.mk')
  exec "setl makeprg=make\\ -f\\ latex.mk\\ ".expand("%:r:t").".pdf" 
endif

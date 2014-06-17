
set sw=2
set iskeyword+=:
"let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_UseMakefile=1

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable('Makefile')
  setlocal makeprg=make
else
  exec "setlocal makeprg=make\\ -f\\ latex.mk\\ " . substitute(bufname("%"),"tex$","pdf", "")
endif



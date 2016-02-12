"if exists("current_compiler")
"  finish
"endif
"let current_compiler = "texw"
"
""if exists(":CompilerSet") != 2
""  command -nargs=* CompilerSet setlocal <args>
""endif
""
""CompilerSet errorformat&		" use the default 'errorformat'
""CompilerSet makeprg=nmake
"compiler tex

" since we're already within a 'compiler' command call, we can't use
" 'compiler' again without a clash on 'CompilerSet' 
runtime! compiler/tex.vim
runtime! compiler/latexmk.vim
let current_compiler = "texw"
" add a simple python erf
setl errorformat+=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m



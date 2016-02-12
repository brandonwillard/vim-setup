
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

"CompilerSet errorformat&		" use the default 'errorformat'
"CompilerSet makeprg=nmake
"compiler tex
compiler latexmk
CompilerSet errorformat+=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m


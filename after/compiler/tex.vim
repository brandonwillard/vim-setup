"if exists("current_compiler")
"  finish
"endif
"let current_compiler = "tex"
"
"if exists(":CompilerSet") != 2
"  command -nargs=* CompilerSet setlocal <args>
"endif
"
"CompilerSet errorformat&		" use the default 'errorformat'
"CompilerSet makeprg=nmake

unlet! current_compiler
runtime! compiler/latexmk.vim

" FIXME: the errorformat doesn't seem to capture
" /home/bwillar0/projects/papers/hs-marginals/src/tex/hs-marginals.tex:911: Package pdftex.def Error: File
"`figures/hs-marginals_ meijer_rewrite_lzp1dz_matplot_1.pdf' not found.


if filereadable('Makefile')
  exec "setl makeprg=make\\ ".expand("%:r:t").".pdf"
elseif filereadable('latex.mk')
  exec "setl makeprg=make\\ -f\\ latex.mk\\ ".expand("%:r:t").".pdf" 
endif

"if exists('g:Make_loaded')
"  "let g:OldMake = function("Make")
"  
"  " Pass-through that simply turns no args into the current buffer's filename
"  " with pdf extension (i.e. builds the buffer's file).
"  fun! LatexMake(args)
"    let l:args = strlen(a:args) ? a:args : expand("%:r:t").".pdf"
"    "OldMake(l:args)
"    call Make(l:args)
"  endfunction
"
"  " Note: for this quickfix stuff to work well, run
"  " make without command echoing (i.e. preface with @)
"  " and pdflatex with -file-line-error.
"
"  command! -nargs=? Make call LatexMake("<args>")
"
"endif


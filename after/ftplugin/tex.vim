
"setl autoindent
setl spell
"setl textwidth=80
"setl formatoptions+=t
setl sw=2
setl conceallevel=0

" remove these annoying latex-box mappings
"iunmap <buffer> [[
"iunmap <buffer> ]]
"imap <buffer> <LocalLeader>[[ 		\begin{
"imap <buffer> <LocalLeader>]]		<Plug>LatexCloseCurEnv
"nmap <buffer> <LocalLeader>ec		<Plug>LatexChangeEnv
"vmap <buffer> <LocalLeader>ws		<Plug>LatexWrapSelection
"vmap <buffer> <LocalLeader>ew		<Plug>LatexEnvWrapSelection
"imap <buffer> <LocalLeader>(( 		\eqref{

if filereadable('Makefile')
  exec "setl makeprg=make\\ ".expand("%:r:t").".pdf"
elseif filereadable('latex.mk')
  exec "setl makeprg=make\\ -f\\ latex.mk\\ ".expand("%:r:t").".pdf" 
endif

if exists('g:Make_loaded')
  "let g:OldMake = function("Make")
  
  " Pass-through that simply turns no args into the current buffer's filename
  " with pdf extension (i.e. builds the buffer's file).
  fun! LatexMake(args)
    let l:args = strlen(a:args) ? a:args : expand("%:r:t").".pdf"
    "OldMake(l:args)
    call Make(l:args)
  endfunction

  " Note: for this quickfix stuff to work well, run
  " make without command echoing (i.e. preface with @)
  " and pdflatex with -file-line-error.

  command! -nargs=? Make call LatexMake("<args>")

endif

let b:thisaux = findfile(expand("%:r:t").".aux", "**4;")
let b:LatexBox_build_dir = fnamemodify(b:thisaux, ":p:h")
let b:build_dir = fnamemodify(b:thisaux, ":p:h")
let b:LatexBox_jobname = fnamemodify(b:thisaux, ":p:r")

"
" Some basic synctex functionality for use with
" qpdfview.
"
" The external sync command looks like:
" qpdfview --unique foobar.pdf#src:foobar.tex:42:0
"
function! SyncTexForward()
  if !exists('b:thispdf')
    let b:thispdf = findfile(expand("%:r:t").".pdf", "**4;")
  endif
  let l:execstr = "!qpdfview --unique ".b:thispdf."\\#src:".expand("%:p").":".line(".").":0 &> /dev/null &"
  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>




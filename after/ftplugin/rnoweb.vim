

setl formatoptions+=croql
setl iskeyword+=_,.,-

" remove these annoying latex-box mappings
"iunmap <buffer> [[
"iunmap <buffer> ]]
"imap <buffer> <LocalLeader>[[ 		\begin{
"imap <buffer> <LocalLeader>]]		<Plug>LatexCloseCurEnv
"nmap <buffer> <LocalLeader>ec		<Plug>LatexChangeEnv
"vmap <buffer> <LocalLeader>ws		<Plug>LatexWrapSelection
"vmap <buffer> <LocalLeader>ew		<Plug>LatexEnvWrapSelection
"imap <buffer> <LocalLeader>(( 		\eqref{

if exists('g:Make_loaded')
  "let g:OldMake = function("Make")
  
  " Pass-through that simply turns no args into the current buffer's filename
  " with pdf extension (i.e. builds the buffer's file).
  fun! LatexMake(args)
    let l:args = strlen(a:args) ? a:args : expand("%:gs?[Rr]nw$?pdf?:t")
    "OldMake(l:args)
    call Make(l:args)
  endfunction

  " Note: had to fix the vim-make plugin by adding the following:
  "   " Output to quickfix.
  "     cgetexpr l:out
  "     let l:len = 0
  "     for d in getqflist()
  "       if d.valid > 0
  "         let l:len = l:len + 1
  "       endif
  "     endfor

  " Note: for this quickfix stuff to work well, run
  " make without command echoing (i.e. preface with @)
  " and pdflatex with -file-line-error.

  "command! -nargs=? Make call LatexMake("<args>")
  command! -nargs=? Make call LatexMake("<args>")

else
  if filereadable('Makefile')
    setl makeprg=make\ %:gs?[Rr]nw$?pdf?:t
    "setl errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
  elseif filereadable('latex.mk')
    exec "setl makeprg=make\\ -f\\ latex.mk\\ " . substitute(bufname("%"),"[Rr]nw$","pdf", "")
    "setl errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
  endif
endif

"
" Some basic synctex functionality for use with
" qpdfview.
"
" The external sync command looks like:
" qpdfview --unique foobar.pdf#src:foobar.tex:42:0
"
function! SyncTexForward()
  if !exists('b:thispdf')
    let b:thispdf = findfile(expand("%:gs?[Rr]nw$?pdf?:t"), "**4;")
  endif
  let l:execstr = "!qpdfview --unique ".b:thispdf."\\#src:".expand("%:p").":".line(".").":0 &> /dev/null &"
  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>



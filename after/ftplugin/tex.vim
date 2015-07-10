
"setl autoindent
"setl spell
"setl textwidth=80
"setl formatoptions+=t
setl formatoptions+=croql
setl sw=2
setl iskeyword+=_,.,-,:

"let maplocalleader = mapleader
" make start-stop block out of the previous word
"imap <buffer> <LocalLeader>tb \begin<Cr>\end<Cr><Esc>4bhdiw$pj$pO
imap <buffer> <LocalLeader>[[ 		\begin{
imap <buffer> <LocalLeader>]]		<Plug>LatexCloseCurEnv
nmap <buffer> <LocalLeader>ec		<Plug>LatexChangeEnv
vmap <buffer> <LocalLeader>ws		<Plug>LatexWrapSelection
vmap <buffer> <LocalLeader>ew		<Plug>LatexEnvWrapSelection
imap <buffer> <LocalLeader>(( 		\eqref{

if exists('g:Make_loaded')
  "let g:OldMake = function("Make")
  
  " Pass-through that simply turns no args into the current buffer's filename
  " with pdf extension (i.e. builds the buffer's file).
  fun! b:Make(args)
    let l:args = strlen(a:args) ? a:args : expand("%:gs?tex?pdf?:t")
    "OldMake(l:args)
    call Make(l:args)
  endfunction

  "command! -nargs=? Make call LatexMake("<args>")
  command! -nargs=? Make call b:Make("<args>")

else
  if filereadable('Makefile')
    setl makeprg=make\ %:gs?tex?pdf?:t
    setl errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
  elseif filereadable('latex.mk')
    exec "setl makeprg=make\\ -f\\ latex.mk\\ " . substitute(bufname("%"),"tex$","pdf", "")
    setl errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
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
    let b:thispdf = findfile(expand("%:gs?tex?pdf?:t"), "**;")
  endif
  let l:execstr = "!qpdfview --unique ".b:thispdf."\\#src:%:p:".line(".").":0 &"
  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>

"
" Reformat lines (getting the spacing correct) {{{
" From http://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim?lq=1
" doesn't really work; no support for $[$]...$[$]
fun! TeX_fmt()
    if (getline(".") != "")
    let save_cursor = getpos(".")
        let op_wrapscan = &wrapscan
        set nowrapscan
        let par_begin = '^\(%D\)\=\s*\($\|\\label\|\\begin\|\\end\|\\\[\|\\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
        let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\\[\|\\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
        norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
        let &wrapscan = op_wrapscan
    call setpos('.', save_cursor) 
    endif
endfun
" }}}


"nmap Q :call TeX_fmt()<CR> 

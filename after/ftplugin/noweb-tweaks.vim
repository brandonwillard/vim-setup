
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
    "let l:args = strlen(a:args) ? a:args : expand("%:gs?[Rr]nw$?pdf?:t")
    "OldMake(l:args)
    call Make(l:args)
  endfunction

  " Note: for this quickfix stuff to work well, run
  " make without command echoing (i.e. preface with @)
  " and pdflatex with -file-line-error.

  command! -nargs=? Make call LatexMake("<args>")

endif

"
" The following Noweb* functions are copied from the vim-r-plugin.
" 
function! NowebNextChunk() range
  let rg = range(a:firstline, a:lastline)
  let chunk = len(rg)
  for var in range(1, chunk)
    let i = search("^<<.*$", "nW")
    if i == 0
      echomsg "There is no next code chunk to go to."
      return
    else
      call cursor(i+1, 1)
    endif
  endfor
  return
endfunction

function! NowebPreviousChunk() range
    let rg = range(a:firstline, a:lastline)
    let chunk = len(rg)
    for var in range(1, chunk)
        let curline = line(".")
        if NowebIsInCode(0)
            let i = search("^<<.*$", "bnW")
            if i != 0
                call cursor(i-1, 1)
            endif
        endif
        let i = search("^<<.*$", "bnW")
        if i == 0
            call cursor(curline, 1)
            echomsg "There is no previous code chunk to go to."
            return
        else
            call cursor(i+1, 1)
        endif
    endfor
    return
endfunction


function! NowebIsInCode(vrb)
  let chunkline = search("^<<", "bncW")
  let docline = search("^@", "bncW")
  if chunkline > docline && chunkline != line(".")
    return 1
  else
    if a:vrb
      echomsg "Not inside a code chunk."
    endif
    return 0
  endif
endfunction

function! NowebSendChunkToTmux(m)
  if NowebIsInCode(0) == 0
      echomsg "Not inside a code chunk."
      return
  endif
  if !exists("g:VimuxRunnerPaneIndex")
    echomsg "No VimuxRunner pane open"
    return
  endif
  let chunkline = search("^<<", "bncW") + 1
  let docline = search("^@", "ncW") - 1
  let lines = getline(chunkline, docline)
  call SourceLines(lines)
  if a:m == "down"
      call NowebNextChunk()
  endif
endfunction

"noremap <buffer> <LocalLeader>cd :call NowebSendChunkToTmux("down")<CR>
"noremap <buffer> <LocalLeader>cc :call NowebSendChunkToTmux("stay")<CR>

noremap <buffer> <LocalLeader>gN :call NowebPreviousChunk()<CR>
noremap <buffer> <LocalLeader>gn :call NowebNextChunk()<CR>

"let b:thisaux = findfile(expand("%:gs?texw$?aux?:t"), "**4;")
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
    "let b:thispdf = findfile(expand("%:gs?[Rr]nw$?pdf?:t"), "**4;")
    let b:thispdf = findfile(expand("%:r:t").".pdf", "**4;")
  endif
  let l:execstr = "!qpdfview --unique ".b:thispdf."\\#src:".expand("%:p").":".line(".").":0 &> /dev/null &"
  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>



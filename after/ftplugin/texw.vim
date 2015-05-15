
" these are reset when noweb syntax is loaded, so these
" settings are in texw's syntax file after loading noweb.
"setl formatoptions+=croql
"setl iskeyword+=_

" noweb syntax file reads these as globals
let noweb_backend="tex"
let noweb_language="python"

setl makeprg=make\ %:gs?[Tt]exw?pdf?:t

"
" The following Noweb* functions are copied from the vim-r-plugin.
" 
function! NowebNextChunk() range
  let rg = range(a:firstline, a:lastline)
  let chunk = len(rg)
  for var in range(1, chunk)
    let i = search("^<<.*$", "nW")
    if i == 0
      echomsg "There is no next code chunk to go."
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
        if RnwIsInRCode(0)
            let i = search("^<<.*$", "bnW")
            if i != 0
                call cursor(i-1, 1)
            endif
        endif
        let i = search("^<<.*$", "bnW")
        if i == 0
            call cursor(curline, 1)
            echomsg "There is no previous R code chunk to go."
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

function! SourceLines(lines)
  let inside_def = 0
  let last_n_ind = 0
  let lines = copy(a:lines)
  for i in range(0, len(lines)-1)
    let line = lines[i]
    if line =~ '^\s*$'
      continue
    endif

    " track indents in python
    if exists("g:noweb_language") && g:noweb_language == "python"
      let n_ind = len(matchstr(lines[i], '^\(\s\)*'))
      if n_ind < last_n_ind
        call VimuxSendKeys("Enter")
      endif
      let last_n_ind = n_ind  
    endif

    call VimuxSendText(escape(line, "`") . "\<C-M>")
  endfor

  " just in case the lines ended at the end
  " of a function declaration
  if exists("g:noweb_language") && g:noweb_language == "python"
    if last_n_ind > 0
      call VimuxSendKeys("Enter")
    endif
  endif
endfunction

noremap <buffer> <LocalLeader>cd :call NowebSendChunkToTmux("down")<CR>
noremap <buffer> <LocalLeader>cc :call NowebSendChunkToTmux("stay")<CR>
"noremap <buffer> <LocalLeader>ch :call NowebSendFHChunkToTmux("stay")<CR>
noremap <buffer> <LocalLeader>gN :call NowebPreviousChunk()<CR>
noremap <buffer> <LocalLeader>gn :call NowebNextChunk()<CR>

nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR>
nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>


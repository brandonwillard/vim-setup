
"
" The following Noweb* functions are adapted from the vim-r-plugin.
" 
if exists("b:noweb_settings_loaded")
  finish
endif
let b:noweb_settings_loaded=1

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

" TODO: these ones...
"noremap <buffer> <LocalLeader>cd :call NowebSendChunkToTmux("down")<CR>
"noremap <buffer> <LocalLeader>cc :call NowebSendChunkToTmux("stay")<CR>

nnoremap <buffer><silent> <Plug>(noweb-prev-chunk) :<C-U>call NowebPreviousChunk()<CR>
nnoremap <buffer><silent> <Plug>(noweb-next-chunk) :<C-U>call NowebNextChunk()<CR>

nmap <buffer> <LocalLeader>gN <Plug>(noweb-prev-chunk)
nmap <buffer> <LocalLeader>gn <Plug>(noweb-next-chunk)




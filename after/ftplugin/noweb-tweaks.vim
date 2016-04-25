
"
" The following Noweb* functions are adapted from the vim-r-plugin.
" 
if exists("b:loaded_noweb_ftplugin")
  finish
endif
let b:loaded_noweb_ftplugin=1

" Chunk functions {{{
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
" }}}

" Chunk mappings {{{
nnoremap <buffer><silent> <Plug>(noweb-prev-chunk) :<C-U>call NowebPreviousChunk()<CR>
nnoremap <buffer><silent> <Plug>(noweb-next-chunk) :<C-U>call NowebNextChunk()<CR>

nmap <buffer> <LocalLeader>gN <Plug>(noweb-prev-chunk)
nmap <buffer> <LocalLeader>gn <Plug>(noweb-next-chunk)
" }}}

" REPL additions {{{

if !exists("b:loaded_repl")
  runtime! plugin/repl.vim
endif

function! NowebSendChunk(...)
    " Function that REPLs code chunks.
    " Takes two arguments:
    "     * First is a string value for which "down" signifies that
    "     the cursor is to jump to the next chunk after sending.
    "     * Second is an optional string that matches the first argument/option
    "     of the chunk (i.e. it IDs the chunk).
  let chunkline = -1
  let docline = -1
  let lines = ""
  if a:0 > 1
      let chunkline = search("^<<\\s*" . a:2, "bncw") + 1
      if chunkline < 2
          echomsg 'Chunk starting with "' . a:2 . '" not found.'
          return
      endif 
      "let docline = search("\\%>".string(chunkline-1)."l\\_.\\{-}\\_^@", "ncwe") - 1
      let endchk = "^@"
      let codelines = [getline(chunkline)]
      while getline(chunkline + 1) !~ endchk
          let chunkline += 1
          let codelines += [getline(chunkline)]
      endwhile
      let lines = join(codelines, "\n")
  else
      if NowebIsInCode(0) == 0
          echomsg "Not inside a code chunk."
          return
      endif
      let chunkline = search("^<<", "bncW") + 1
      let docline = search("^@", "ncW") - 1
      let lines = join(getline(chunkline, docline), "\n")
  endif
  call b:ReplSendString(lines)
  if a:1 == "down"
      call NowebNextChunk()
  endif
endfunction

"
" From the Nvim-R plugin
"
function! NowebSendFHChunk()
    let begchk = "^<<.*>>=\$"
    let endchk = "^@"

    let codelines = []
    let here = line(".")
    let curbuf = getline(1, "$")
    let idx = 0
    while idx < here
        if curbuf[idx] =~ begchk
            let idx += 1
            while curbuf[idx] !~ endchk && idx < here
                let codelines += [curbuf[idx]]
                let idx += 1
            endwhile
        else
            let idx += 1
        endif
    endwhile

    let comblines = join(codelines, "\n")
    call b:ReplSendString(comblines)
endfunction



command! NowebSendChunkCmd call NowebSendChunk("stay") 
command! NowebSendFHChunkCmd call NowebSendFHChunk() 

nnoremap <buffer><silent> <Plug>(noweb-send-chunk) :<C-U>call NowebSendChunk("stay")<CR>
nnoremap <buffer><silent> <Plug>(noweb-send-fh-chunk) :<C-U>call NowebSendFHChunk()<CR>

nmap <buffer> <LocalLeader>tc <Plug>(noweb-send-chunk)
nmap <buffer> <LocalLeader>tC <Plug>(noweb-send-fh-chunk)

" Here's a little custom addition that runs a chunk with the
" name 'pweave_code'.  This can be used to run a weave/build
" command from Python within the REPL session (so that, for example, weaved chunk
" variables are exposed to the session).
nmap <buffer> <LocalLeader>tw :<C-U>call NowebSendChunk("stay", "pweave_code")<CR> 

" }}}



" vim:foldmethod=marker:foldlevel=0

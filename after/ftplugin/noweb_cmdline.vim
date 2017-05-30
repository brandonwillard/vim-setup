if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
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
  else
      if NowebIsInCode(0) == 0
          echomsg "Not inside a code chunk."
          return
      endif
      let chunkline = search("^<<", "bncW") + 1
      let docline = search("^@", "ncW") - 1
      let codelines = getline(chunkline, docline)
  endif
  call b:cmdline_source_fun(codelines)
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
        let enabled = pyeval("is_noweb_chunk_enabled('".escape(curbuf[idx], "\\\"'")."')") 
        "if curbuf[idx] =~ begchk
        if enabled == 1
            let idx += 1
            while curbuf[idx] !~ endchk && idx < here
                let codelines += [curbuf[idx]]
                let idx += 1
            endwhile
        else
            let idx += 1
        endif
    endwhile

    call b:cmdline_source_fun(codelines)

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

" TODO: Do we need to source the corresponding noweb language?
" E.g.
"   exe 'runtime! **/'.b:noweb_language.'_cmdline.vim'
" or
"   let b:cmdline_app = b:noweb_language
"   ...
"   call VimCmdLineSetApp(...)

" vim:foldmethod=marker:foldlevel=0

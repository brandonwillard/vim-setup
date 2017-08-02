if exists("b:noweb_cmdline_loaded")
  finish
endif

let b:noweb_cmdline_loaded = 1

let b:noweb_chunk_enabled_opts = {'evaluate': v:true, 'fig': v:false}

"
" Wrap an existing source function with a code chunk test.
" XXX: Doesn't work for vimcmdline's send-line commands, since that calls
" nvim's `jobsend` directly.
"
if !exists("b:cmdline_source_fun_backend")
  " echom "noweb cmdline_source_fun=".string(b:cmdline_source_fun)
  let b:cmdline_source_fun_backend = b:cmdline_source_fun
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
  call b:cmdline_source_fun_backend(codelines)
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
        let enabled = pyeval("chunk_enabled('".escape(curbuf[idx], "\\\"'")."', vim.current.buffer.vars.get('noweb_chunk_enabled_opts', {}))") 
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

    call b:cmdline_source_fun_backend(codelines)

endfunction

function! ReplSendString_noweb(lines)
  if NowebIsInCode(0) == 0
      echomsg "Not inside a code chunk."
      return
  else
      return b:cmdline_source_fun_backend(a:lines) 
  endif
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

let b:cmdline_source_fun = function("ReplSendString_noweb")
" let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}

" TODO: Do we need to source the corresponding noweb language?
" E.g.
" exe 'runtime! **/'.b:noweb_language.'_cmdline.vim'
" or
"   let b:cmdline_app = b:noweb_language
"   ...
"   call VimCmdLineSetApp(...)

" reset vimcmdline settings for this filetype
"call VimCmdLineSetApp(b:noweb_language)

" vim:foldmethod=marker:foldlevel=0:ts=2:sts=2:sw=2

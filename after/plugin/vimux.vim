
let scriptnames = GetVimCommandOutput("scriptnames")
if match(scriptnames, "/".expand("%:t")) < 0
  finish
endif

"--------------------------------------------------------
"
" functions/commands
"
" uses vim-r-plugin mappings when possible
"
" Vimux settings
" could use this to get keywords: expand("<cword>")
" or this to get visual selection: getline("'<","'>")
" current line: getline(".")
"
function! VimuxSlime()
  call VimuxSendText(escape(@z,'`\'))
  call VimuxSendKeys("Enter")
endfunction

" send visual selection
if empty(mapcheck("<LocalLeader>sa"))
  vmap <LocalLeader>sa "zy :call VimuxSlime()<CR>  
  vmap <LocalLeader>sd "zy :call VimuxSlime()<CR>  
else
  vmap <LocalLeader>ta "zy :call VimuxSlime()<CR>  
  vmap <LocalLeader>td "zy :call VimuxSlime()<CR>  
endif

" send line
if empty(mapcheck("<LocalLeader>l"))
  map <LocalLeader>l "zY :call VimuxSlime()<CR>  
else
  map <LocalLeader>tl "zY :call VimuxSlime()<CR>  
endif

" send/print word
if empty(mapcheck("<LocalLeader>rp"))
  nmap <LocalLeader>rp "zyiw :call VimuxSlime()<CR>  
else
  nmap <LocalLeader>tp "zyiw :call VimuxSlime()<CR>  
endif

function! VimuxBufferStart()
  if exists("g:vimux_run_command")
    call VimuxRunCommand(g:vimux_run_command)
  else
    call VimuxOpenPane()
  endif
endfunction


" general run/open and quit/close
if empty(mapcheck("<LocalLeader>rf"))
  nnoremap <LocalLeader>rf :call VimuxBufferStart()<CR>  
else
  nnoremap <LocalLeader>tr :call VimuxBufferStart()<CR>  
endif

if empty(mapcheck("<LocalLeader>rq"))
  nnoremap <LocalLeader>rq :VimuxCloseRunner<CR>
else
  nnoremap <LocalLeader>tq :VimuxCloseRunner<CR>
endif



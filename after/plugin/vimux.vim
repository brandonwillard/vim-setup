
"--------------------------------------------------------
"
" functions/commands
"
" Vimux settings
" could use this to get keywords: expand("<cword>")
" or this to get visual selection: getline("'<","'>")
" current line: getline(".")
"
function! VimuxSlime()
  " remove the trailing newline
  "call VimuxSendText(substitute(escape(@z,"`"),'\n*$','','g'))
  call VimuxSendText(escape(@z,"`"))
  call VimuxSendKeys("Enter")
endfunction

" send visual selection
vnoremap <LocalLeader>ts "zy :call VimuxSlime()<CR>  
" send line
nnoremap <LocalLeader>tl "zY :call VimuxSlime()<CR>  
" send word
nnoremap <LocalLeader>tp "zyiw :call VimuxSlime()<CR>  
" general run/open and quit/close
nnoremap <LocalLeader>tr :call VimuxOpenPane()<CR>  
nnoremap <LocalLeader>tq :VimuxCloseRunner<CR>



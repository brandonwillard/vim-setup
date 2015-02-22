
"
" check if this is c++ and there's a jamfile
" 
function! BjamCheck()
  if filereadable("Jamfile") && &filetype == "cpp"
    " run bjam in directory of buffer
    setl makeprg=bjam\ %:h
    :compiler gcc
    let b:compiler_gcc_ignore_unmatched_lines=1
  endif
endfunction

setl makeprg=bjam
:compiler gcc
let b:compiler_gcc_ignore_unmatched_lines=1


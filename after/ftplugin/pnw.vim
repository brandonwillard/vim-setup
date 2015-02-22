
setl iskeyword+=_

let b:noweb_backend="markdown"
let b:noweb_language="python"

nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR>
nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>



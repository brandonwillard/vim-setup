
let b:noweb_backend="tex"
let b:noweb_language="python"
setl iskeyword+=_

nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR>
nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>


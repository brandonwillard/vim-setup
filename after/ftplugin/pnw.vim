
setl iskeyword+=_

" noweb syntax file reads these as globals
let noweb_backend="markdown"
let noweb_language="python"

nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR>
nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>



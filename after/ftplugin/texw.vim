
setl formatoptions+=croql
setl iskeyword+=_

" noweb syntax file reads these as globals
let noweb_backend="tex"
let noweb_language="python"

setl makeprg=make\ %:gs?[Tt]exw?pdf?:t

nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR>
nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>


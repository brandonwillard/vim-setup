
" these are reset when noweb syntax is loaded, so these
" settings are in pnw's syntax file after loading noweb.
"setl formatoptions+=croql
"setl iskeyword+=_

" noweb syntax file reads these as globals
let noweb_backend="markdown"
let noweb_language="python"

" not sure if this should actually build a md file or not...
setl makeprg=make\ %:gs?[Pp]nw?html?:t

nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR>
nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>



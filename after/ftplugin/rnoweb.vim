

setl formatoptions+=croql
setl iskeyword+=_,.,-

setl makeprg=make\ %:gs?[Rr]nw?pdf?:t

" remove these annoying latex-box mappings
"iunmap <buffer> [[
"iunmap <buffer> ]]


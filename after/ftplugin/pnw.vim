if exists("b:loaded_pnw_ftplugin")
  finish
endif

let b:loaded_pnw_ftplugin = 1

let b:noweb_backend="markdown"
let b:noweb_language="python"

"runtime after/ftplugin/noweb_more.vim
"runtime after/ftplugin/python.vim

" TODO: Use projectionist
setl makeprg=make\ %:gs?[Pp]nw$?md?:t

" vim:foldmethod=marker:foldlevel=0

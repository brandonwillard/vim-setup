"
" FIXME: need to update this to match `.texw`.
"
if exists("b:loaded_pnw_ftplugin")
  finish
endif

let b:loaded_pnw_ftplugin = 1

let b:noweb_backend="markdown"
let b:noweb_language="python"

runtime after/ftplugin/noweb-tweaks.vim
"runtime after/ftplugin/python.vim

" these are reset when noweb syntax is loaded, so these
" settings are in pnw's syntax file after loading noweb.
"setl formatoptions+=croql
"setl iskeyword+=_

" not sure if this should actually build a md file or not...
setl makeprg=make\ %:gs?[Pp]nw$?md?:t

" vim:foldmethod=marker:foldlevel=0

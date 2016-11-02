
if exists("b:loaded_texw_ftplugin")
  finish
endif

let b:loaded_texw_ftplugin = 1

" these are reset when noweb syntax is loaded, so these
" settings are in texw's syntax file after loading noweb.

" noweb syntax file reads these as globals
let b:noweb_backend="tex"
let b:noweb_language="python"

" TODO: need to get multi-filetypes working
runtime after/ftplugin/noweb-tweaks.vim
"runtime after/ftplugin/python.vim

setl conceallevel=0

compiler texw

" vim:ts=18  fdm=marker

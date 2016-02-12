
" these are reset when noweb syntax is loaded, so these
" settings are in texw's syntax file after loading noweb.
"setl formatoptions+=croql
"setl iskeyword+=_
"

" noweb syntax file reads these as globals
let noweb_backend="tex"
let noweb_language="python"

runtime after/ftplugin/noweb-tweaks.vim
runtime after/ftplugin/python.vim
runtime after/ftplugin/tex.vim
runtime ftplugin/python/jedi.vim

setl conceallevel=0

compiler texw


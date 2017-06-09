if exists("b:loaded_texw_ftplugin")
  finish
endif

let b:loaded_texw_ftplugin = 1

" these are reset when noweb syntax is loaded, so these
" settings are in texw's syntax file after loading noweb.

" noweb syntax file reads these as globals
let b:noweb_backend="tex"
let b:noweb_language="python"

if exists('*textobj#user#plugin')
  call textobj#user#plugin('noweb', {
  \   'code': {
  \     'pattern': ['^<<.*>>=', '^@'],
  \     'select-a': 'aP',
  \     'select-i': 'iP',
  \   },
  \ })
endif

" TODO: Determine if a multi-filetype is better (i.e. `ft=texw.noweb`).
runtime after/ftplugin/noweb_more.vim

setl conceallevel=0

if exists("b:latex_project_let_vars")
  let g:projectionist_heuristics["src/python/&output/"] = { 
        \ "*.texw": { "let": b:latex_project_let_vars }
        \ } 
endif

if exists("b:neomake_tex_pdfmake_maker")
  let b:neomake_noweb_pdfmake_maker = b:neomake_tex_pdfmake_maker
endif

if exists("b:neomake_tex_rubberinfo_maker")
  let b:neomake_noweb_rubberinfo_maker = b:neomake_tex_rubberinfo_maker
endif

if exists("b:neomake_tex_enabled_makers")
  let b:neomake_noweb_enabled_makers = b:neomake_tex_enabled_makers
endif

compiler texw

" vim:foldmethod=marker:foldlevel=0

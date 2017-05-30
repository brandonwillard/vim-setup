if exists("b:loaded_rnoweb_ftplugin")
  finish
endif

let b:loaded_rnoweb_ftplugin = 1

setl iskeyword+=-

" runtime after/ftplugin/noweb_more.vim
" runtime after/ftplugin/r.vim

nmap <buffer> <LocalLeader>tk <Plug>RKnit
vmap <buffer> <LocalLeader>tk <Plug>RKnit

nmap <buffer> <LocalLeader>tm <Plug>RMakePDFK
vmap <buffer> <LocalLeader>tm <Plug>RMakePDFK

" vim:foldmethod=marker:foldlevel=0


if exists("b:did_texw_settings")
  finish
endif

let b:did_texw_settings = 1

" these are reset when noweb syntax is loaded, so these
" settings are in texw's syntax file after loading noweb.

" noweb syntax file reads these as globals
let noweb_backend="tex"
let noweb_language="python"

" TODO: need to get multi-filetypes working
runtime after/ftplugin/noweb-tweaks.vim

" OK, here's a hack: 
" First, we load the standard tex settings,
" save some key option values in local variables,
" then we do the same for Python.
" Now, we can create wrapper functions that check the
" cursor location to determine which settings to use.

" TODO: what about the standard ftplugin files?
runtime! after/ftplugin/tex.vim after/ftplugin/tex_*.vim after/ftplugin/tex/*.vim
unlet! b:did_indent
runtime! indent/tex.vim indent/tex/*.vim 


let b:tex_indentexpr = &indentexpr
let b:tex_indentkeys = &indentkeys

runtime! ftplugin/python/*.vim after/ftplugin/python.vim after/ftplugin/python/*.vim
unlet! b:did_indent
runtime! indent/python.vim indent/python/*.vim 

let b:python_indentexpr = &indentexpr
let b:python_indentkeys = &indentkeys


setl conceallevel=0

compiler texw

function! GetCondOption(name)
  if NowebIsInCode(0)
    return eval(b:python_{a:name})
  else
    return eval(b:tex_{a:name}) 
  endif
endfunction

setl indentexpr=GetCondOption('indentexpr')
setl indentkeys=GetCondOption('indentkeys')
"let &l:indentexpr=GetCondOption("indentexpr")
"let &l:indentkeys=GetCondOption("indentkeys")

" TODO: same for indentkeys (if possible)
"setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except


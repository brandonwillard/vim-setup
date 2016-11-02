" Noweb syntax file
"
" Remarks: Inspired by noweb.vim--McDermott and vim-pweave.
"

" Remove any old syntax stuff hanging around
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
  w
endif

syn case match

if !exists("b:noweb_backend")
  let b:noweb_backend = "nosyntax"
endif

if version < 600
  execute "source <sfile>:p:h/" . b:noweb_backend . ".vim"
else
  execute "runtime! syntax/" . b:noweb_backend . ".vim"
endif

" This was probably set by the previous source/runtime call.
if exists("b:current_syntax")
  unlet b:current_syntax
endif

"syntax match codeChunkStart "^<<.*>>=$" display
"syntax match codeChunkEnd "^@$" display
"highlight link codeChunkStart Type
"highlight link codeChunkEnd Type

if !exists("b:noweb_language")
  let b:noweb_language = "nosyntax"
endif

" Load the chunk code syntax settings into a variable:
execute "syntax include @nowebCode syntax/" . b:noweb_language . ".vim"

if exists("noweb_fold_code") && noweb_fold_code == 1
  setl foldmethod=syntax

  syn region nowebChunk matchgroup=nowebDelimiter
        \ start="^<<.*>>=" end="^@"
        \ matchgroup=nowebDelimiter
        \ contains=@nowebCode,nowebChunkReference,nowebChunk
        \ containedin=ALL
        \ fold keepend

  "syn region nowebChunk start="^<<.*>>=$" end="^@$"
  "      \contains=@nowebCode transparent fold containedin=ALL keepend
else
  syn region nowebChunk matchgroup=nowebDelimiter start="^<<.*>>="
        \ matchgroup=nowebDelimiter end="^@"
        \ contains=@nowebCode,nowebChunkReference,nowebChunk
        \ containedin=ALL
        \ keepend

  "syn region nowebChunk start="^<<.*>>=$" end="^@$"
  "      \ contains=@nowebCode containedin=ALL keepend
endif

syn match nowebChunkReference "^<<.*>>=$" contained

syn region nowebSexpr matchgroup=Delimiter start="\\Sexpr{"
      \ matchgroup=Delimiter end="}" contains=@nowebCode

syn region nowebSweaveOpts matchgroup=Delimiter
      \ start="\\SweaveOpts{" matchgroup=Delimiter end="}"


syn cluster noweb
      \ contains=nowebChunk,nowebChunkReference,nowebDelimiter,
      \nowebSexpr,nowebSweaveOpts

hi def link nowebDelimiter Delimiter
hi def link nowebSweaveOpts Statement
hi def link nowebChunkReference Delimiter

" Could use b:noweb_backend . b:noweb_language
let b:current_syntax = "noweb"

" vim:ts=18  fdm=marker

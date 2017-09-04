" Noweb syntax file
"
" FIXME TODO: Check out how `vimScriptDelim`, `vimPythonRegion` works in VimL
" files; it seems to not have the same weird problem overlapping python issue
" seen with statements like `blah_12`, where the `12` is parsed as a separate
" numeric literal syntax token.
"
" Nevermind, this is it:
"
"  let s:pythonpath= fnameescape(expand("<sfile>:p:h")."/python.vim")
"  if !filereadable(s:pythonpath)
"   for s:pythonpath in split(globpath(&rtp,"syntax/python.vim"),"\n")
"    if filereadable(fnameescape(s:pythonpath))
"     let s:pythonpath= fnameescape(s:pythonpath)
"     break
"    endif
"   endfor
"  endif
"  if g:vimsyn_embed =~# 'P' && filereadable(s:pythonpath)
"   unlet! b:current_syntax
"   exe "syn include @vimPythonScript ".s:pythonpath
"   VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+py\%[thon]3\=\s*<<\s*\z(.*\)$+ end=+^\z1$+	contains=@vimPythonScript
"   VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+py\%[thon]3\=\s*<<\s*$+ end=+\.$+		contains=@vimPythonScript
"   VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+Py\%[thon]2or3\s*<<\s*\z(.*\)$+ end=+^\z1$+		contains=@vimPythonScript
"   VimFoldP syn region vimPythonRegion matchgroup=vimScriptDelim start=+Py\%[thon]2or3\=\s*<<\s*$+ end=+\.$+		contains=@vimPythonScript
"   syn cluster vimFuncBodyList	add=vimPythonRegion
"  else
"   syn region vimEmbedError start=+py\%[thon]3\=\s*<<\s*\z(.*\)$+ end=+^\z1$+
"   syn region vimEmbedError start=+py\%[thon]3\=\s*<<\s*$+ end=+\.$+
"  endif
"  unlet s:pythonpath
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

if !exists("b:noweb_language")
  let b:noweb_language = "nosyntax"
endif

" This was probably set by the previous source/runtime call.
if exists("b:current_syntax")
  unlet b:current_syntax
endif

if version < 600
  execute "source <sfile>:p:h/" . b:noweb_backend . ".vim"
else
  execute "runtime! syntax/" . b:noweb_backend . ".vim"
endif

unlet! b:current_syntax

" Load the chunk code syntax settings into a variable:
execute "syntax include @nowebCode syntax/" . b:noweb_language . ".vim"

unlet! b:current_syntax

if exists("noweb_fold_code") && noweb_fold_code == 1
  setl foldmethod=syntax

  syn region nowebChunk matchgroup=nowebDelimiter
        \ start="^<<\_.\{-}>>=" end="^@"
        \ matchgroup=nowebDelimiter
        \ contains=@nowebCode,nowebChunkReference,nowebChunk
        \ containedin=ALL
        \ fold keepend

else
  syn region nowebChunk matchgroup=nowebDelimiter start="^<<\_.\{-}>>="
        \ matchgroup=nowebDelimiter end="^@"
        \ contains=@nowebCode,nowebChunkReference,nowebChunk
        \ containedin=ALL
        \ keepend

endif

syn match nowebChunkReference "^<<\_.\{-}>>=$" contained

syn region nowebSexpr matchgroup=Delimiter start="\\Sexpr{"
      \ matchgroup=Delimiter end="}" contains=@nowebCode
      \ containedin=ALLBUT,nowebChunk oneline

" Pweave specific?
syn region nowebSexprPweave matchgroup=Delimiter start="<%=\="
      \ matchgroup=Delimiter end="%>" contains=@nowebCode
      \ containedin=ALLBUT,nowebChunk oneline

syn region nowebSweaveOpts matchgroup=Delimiter
      \ start="\\SweaveOpts{" matchgroup=Delimiter end="}"
      \ containedin=ALLBUT,nowebChunk oneline


syn cluster noweb
      \ contains=nowebChunk,nowebChunkReference,nowebDelimiter,
      \nowebSexpr,nowebSexprPweave,nowebSweaveOpts

" NOTE: This seems to help with syncing.
syn sync match SyncNowebChunk grouphere nowebChunk "^<<\_.\{-}>>="

hi def link nowebDelimiter Delimiter
hi def link nowebSweaveOpts Statement
hi def link nowebChunkReference Delimiter

" Could use b:noweb_backend . b:noweb_language
let b:current_syntax = "noweb"

" vim:foldmethod=marker:foldlevel=0

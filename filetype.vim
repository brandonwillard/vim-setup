if exists("did_load_filetypes") 
  finish 
endif 


" check if this is c++ and there's a jamfile
function! BjamCheck()
  if filereadable("Jamfile") && &filetype == "cpp"
    " run bjam in directory of buffer
    setl makeprg=bjam\ %:h
    :compiler gcc
    let g:compiler_gcc_ignore_unmatched_lines=1
  endif
endfunction



augroup filetypedetect 
  " jam detection and ability to compile from the jam file
  au! BufRead,BufNewFile Jamroot,Jamfile,*.jam setfiletype jam |
        \ setl makeprg=bjam |
        \ :compiler gcc |
        \ let g:compiler_gcc_ignore_unmatched_lines=1

  " setup for make bjam
  au filetype cpp call BjamCheck()

  au! BufRead,BufNewFile *.ladot setfiletype dot |
        \ setl autoindent |
        \ setl makeprg=perl\ ~/pladot.pl\ %

  au! BufRead,BufNewFile *.md setfiletype markdown

  au! BufRead,BufNewFile *.texw setfiletype noweb |
    \ let noweb_backend="tex"      |
    \ let noweb_language="python"  |
    \ setl iskeyword+=_ |
    \ nnoremap <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR> |
    \ nnoremap <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>
    "\ call NowebPySetup() |

  au! BufRead,BufNewFile *.Pnw,*.pnw setfiletype noweb |
    \ let noweb_backend="markdown" |
    \ let noweb_language="python"  |
    \ setl iskeyword+=_ |
    \ nnoremap <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR> |
    \ nnoremap <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR>
    "\ call NowebPySetup() |


  "
  " Setup Vimux for specific interactive sessions
  "
  " remove nocorrect if you're not using zshell (it stops the input
  " requirement when/if ipython doesn't exist)
  au filetype python 
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR> |
        \ nnoremap <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR> |
        \ setl iskeyword+=_

  au filetype scala 
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("scala")<CR>
  au filetype matlab 
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("matlab -nodisplay")<CR>
  au filetype haskell 
        \ setlocal formatoptions+=croql |
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("ghci --interactive")<CR>

augroup END



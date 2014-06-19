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

  "au filetype tex set makeprg=pdflatex\ -shell-escape\ % | 
  "    \ setl autoindent |
  "    \ setl spell |
  "    \ setl textwidth=80 |
  "    \ setl formatoptions+=t |
  "    "\ let b:tex_flavor |
  "    \ :compiler tex

  " add new comment leader after <enter>
  au filetype r setlocal formatoptions-=t formatoptions+=croql

augroup END



if exists("did_load_filetypes") 
  finish 
endif 

augroup filetypedetect 

  au! BufRead,BufNewFile Jamroot,Jamfile,*.jam setfiletype jam

  au! BufRead,BufNewFile *.ladot setfiletype dot

  au! BufRead,BufNewFile *.Md,*.md setfiletype markdown
    
  au! BufRead,BufNewFile *.Texw,*.texw setfiletype=python.texw

  au! BufRead,BufNewFile *.Pnw,*.pnw setfiletype=python.pnw

  au! FileType python,r,*python*,rnoweb :runtime! repl.vim

augroup END


augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END


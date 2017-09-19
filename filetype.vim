if exists("did_load_filetypes") 
  finish 
endif 

augroup filetypedetect 
  au! BufRead,BufNewFile Jamroot,Jamfile,*.jam setfiletype jam
  au! BufRead,BufNewFile *.ladot setfiletype dot
  au! BufRead,BufNewFile *.Md,*.md setfiletype markdown
  au! BufRead,BufNewFile *.psql,*.pgsql setfiletype sql | SQLSetType pgsql
augroup END


" unlist quickfix filetype buffers
augroup qf
  au!
  au FileType qf set nobuflisted
augroup END

" vim:foldmethod=marker:foldlevel=0

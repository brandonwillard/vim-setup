if exists("did_load_filetypes") 
  finish 
endif 

augroup filetypedetect 

  au! BufRead,BufNewFile Jamroot,Jamfile,*.jam setfiletype jam

  au! BufRead,BufNewFile *.ladot setfiletype dot

  au! BufRead,BufNewFile *.Md,*.md setfiletype markdown

  au! BufRead,BufNewFile *.Texw,*.texw setfiletype texw

  au! BufRead,BufNewFile *.Pnw,*.pnw setfiletype pnw

augroup END



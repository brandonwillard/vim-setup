if exists("did_load_filetypes") 
  finish 
endif 

augroup filetypedetect 

  au! BufRead,BufNewFile Jamroot,Jamfile,*.jam setfiletype jam

  au! BufRead,BufNewFile *.ladot setfiletype dot

  au! BufRead,BufNewFile *.Md,*.md setfiletype markdown
    
  au! BufRead,BufNewFile *.Texw,*.texw let b:noweb_language='python' | 
        \let b:noweb_backend='tex' | setfiletype texw 

  au! BufRead,BufNewFile *.Pnw,*.pnw let b:noweb_language='python' | 
        \let b:noweb_backend='markdown' | setfiletype pnw 
  
  au! BufRead,BufNewFile *.Rmd,*.rmd let b:noweb_language='r' | let b:noweb_backend='markdown'

  au! FileType python,r,*python*,rnoweb,noweb :runtime! repl.vim

augroup END


" unlist quickfix filetype buffers
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

" vim:ts=18  fdm=marker

setl sw=2
setl conceallevel=0
set foldlevel=1

" section jumping
noremap <buffer> <silent> <Leader>gn :<c-u>call TexJump2Section(v:count1, '')<CR>
noremap <buffer> <silent> <Leader>gN :<c-u>call TexJump2Section(v:count1, 'b')<CR>

function! TexJump2Section(cnt, dir)
  let i = 0
  let pat = '^\s*\\\(part\|chapter\|\(sub\)*section\|paragraph\)\>\|\%$\|\%^'
   let flags = 'W' . a:dir
   while i < a:cnt && search(pat, flags) > 0
     let i = i+1
   endwhile
   let @/ = pat
 endfunction

function! s:ConfigureLatexBuildEnv()
  " We assume there is log output to work from...
  let b:latex_log_file = findfile(expand("%:r:t").".log", "**2;")

  if b:latex_log_file == ''
    call xolox#misc#msg#warn('No reference TeX log file found!')
    let b:latex_pdf_file = ''
    let b:latex_build_file = ''
    let g:vimtex_latexmk_build_dir = ''
  else
    let b:latex_pdf_file = fnamemodify(b:latex_log_file, ":p:r").".pdf" 
    let b:latex_build_dir = fnamemodify(b:latex_log_file, ":p:h")
    let g:vimtex_latexmk_build_dir = b:latex_build_dir
  endif
endfunction

call s:ConfigureLatexBuildEnv() 

"
" Some basic synctex functionality for use with
" qpdfview.
"
" The external sync command looks like:
" qpdfview --unique --instance VIMSERVER123 foobar.pdf#src:foobar.tex:42:0
"
function! SyncTexForward()
  if !exists('b:latex_pdf_file') || b:latex_pdf_file == ''
    call xolox#misc#msg#info('b:latex_pdf_file not instantiated; finding TeX settings...')
    call s:ConfigureLatexBuildEnv() 
  endif

  if !filereadable(b:latex_pdf_file)
    call xolox#misc#msg#warn('No pdf file found for SyncTeX!')
    return
  endif

  let l:inst_name = substitute(v:servername, '\/', '_', 'g')
  let l:execstr = "!NVIM_LISTEN_ADDRESS=".v:servername
  let l:execstr .= " qpdfview --unique --instance ".l:inst_name." "
  let l:execstr .= b:latex_pdf_file."\\#src:".expand("%:p")
  let l:execstr .= ":".line(".").":0 &> /dev/null &"

  call xolox#misc#msg#debug(l:execstr)

  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>

compiler tex

" vim:foldmethod=marker:foldlevel=0

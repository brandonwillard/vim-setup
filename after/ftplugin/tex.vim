setl shiftwidth=2
setl conceallevel=0
setl formatoptions+=croql
setl iskeyword+=_,.,-,:
setl foldlevel=1

if exists('g:latex_project_let_vars')
  let g:projectionist_heuristics['src/tex/&output/'] = { 
        \ 'src/tex/*.tex': { 
        \ 'let': g:latex_project_let_vars,
        \ 'alternate': 'src/tex/{}.tex',
        \ 'type': 'source'
        \ }} 
endif

" section jumping
noremap <buffer> <silent> <Leader>gn :<c-u>call TexJump2Section(v:count1, '')<CR>
noremap <buffer> <silent> <Leader>gN :<c-u>call TexJump2Section(v:count1, 'b')<CR>

function! TexJump2Section(cnt, dir)
  let l:i = 0
  let l:pat = '^\s*\\\(part\|chapter\|\(sub\)*section\|paragraph\)\>\|\%$\|\%^'
  let l:flags = 'W' . a:dir
  while l:i < a:cnt && search(l:pat, l:flags) > 0
    let l:i = l:i+1
  endwhile
  let @/ = l:pat
endfunction

" TODO: Figures (and output) dir could be discovered from contents of TeX and/or Makefile, no?
let b:neomake_tex_pdfmake_maker = {
    \ 'exe': 'make',
    \ 'args': [expand('%:r:t').'.pdf'],
    \ 'errorformat': &errorformat,
    \ 'buffer_output': 0,
    \ 'remove_invalid_entries': 1
    \ }

let b:neomake_tex_clean_maker = {
    \ 'exe': 'make',
    \ 'args': ['clean'],
    \ 'errorformat': &errorformat,
    \ 'buffer_output': 0,
    \ 'remove_invalid_entries': 1
    \ }

let b:neomake_tex_rubberinfo_maker = neomake#makers#ft#tex#rubberinfo()
" {'errorformat': '%f:%l: %m,%f:%l-%\d%\+: %m,%f: %m', 'exe': 'rubber-info'} 


let b:neomake_tex_enabled_makers = ['pdfmake', 'rubberinfo']
"'errorformat': '%-P**%f,%-P**"%f",%E! LaTeX %trror: %m,%E%f:%l: %m,%E! %m,%Z<argument> %m,%Cl.%l %m,%+WLaTeX Font Warning: %.%#line %l%.%#,%-CLaTeX Font Warning: %m,%-C(Font)%m,%+WLaTeX %.%#Warning: %.%#line %l%.%#,%+WLaTeX %.%#Warning: %m,%+WOverfull %\%\hbox%.%# at lines %l--%*\d,%+WUnderfull %\%\hbox%.%# at lines %l--%*\d,%+WPackage natbib Warnin g: %m on input line %l%.,%+WPackage biblatex Warning: %m,%-C(biblatex)%.%#in t%.%#,%-C(biblatex)%.%#Please v%.%#,%-C(biblatex)%.%#LaTeX a%.%#,%-C(biblatex)%m,%-Z(babel)%.%#input line %l.,%-C (babel)%m,%+WPackage hyperref Warning: %m,%-C(hyperref)%.%#on input line %l.,%-C(hyperref)%m,%+WPackage scrreprt Warning: %m,%-C(scrreprt)%m,%+WPackage fixltx2e Warning: %m,%-C(fixltx2e)%m,% +WPackage titlesec Warning: %m,%-C(titlesec)%m,%-G%.%#'

compiler tex

"""
" Some basic synctex functionality for use with
" qpdfview.
"
" The external sync command looks like:
" qpdfview --unique --instance VIMSERVER123 foobar.pdf#src:foobar.tex:42:0
"
function! SyncTexForward()
  if !exists('b:latex_pdf_file') || b:latex_pdf_file == ''
    call xolox#misc#msg#warn('b:latex_pdf_file not set')
    return
  endif

  if !filereadable(b:latex_pdf_file)
    call xolox#misc#msg#warn('No pdf file found for SyncTeX!')
    return
  endif

  let l:inst_name = substitute(v:servername, '[\/\.\-]', '_', 'g')
  let l:execstr = "!NVIM_LISTEN_ADDRESS=".v:servername
  let l:execstr .= " qpdfview --unique --instance ".l:inst_name." "
  let l:execstr .= b:latex_pdf_file."\\#src:".expand("%:p")
  let l:execstr .= ":".line(".").":0 &> /dev/null &"

  call xolox#misc#msg#debug(l:execstr)

  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>

" vim:foldmethod=marker:foldlevel=0

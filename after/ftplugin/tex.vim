setl shiftwidth=2
setl conceallevel=0
setl formatoptions+=croql
setl iskeyword+=_,.,-,:
setl foldlevel=1

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

let b:latex_project_let_vars = [ 
      \   ["b:latex_build_dir", '"{project}/output"'],
      \   ["b:latex_pdf_file", '"{project}/output/{basename}.pdf"'],
      \   ["g:vimtex_latexmk_build_dir", '"{project}/output"']
      \ ]

let b:neomake_tex_pdfmake_maker = {
    \ 'exe': 'make',
    \ 'args': [expand("%:r:t").".pdf"],
    \ 'errorformat': &errorformat,
    \ 'buffer_output': 0,
    \ 'remove_invalid_entries': 1
    \ }

let b:neomake_tex_rubberinfo_maker = neomake#makers#ft#tex#rubberinfo()

" Add project-specific neomake buffer vars
" NOTE: We're referencing a buffer variable initialized by projectionist
let b:latex_project_let_vars += [ 
      \   ["b:neomake_tex_rubberinfo_maker.args", '["--into", b:latex_build_dir]']
      \ ]

let b:neomake_tex_enabled_makers = ['pdfmake', 'rubberinfo']

let g:projectionist_heuristics["src/tex/&output/"] = { 
      \ "*.tex|*.texw": { "let": b:latex_project_let_vars }
      \ } 

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

  let l:inst_name = substitute(v:servername, '[\/\.]', '_', 'g')
  let l:execstr = "!NVIM_LISTEN_ADDRESS=".v:servername
  let l:execstr .= " qpdfview --unique --instance ".l:inst_name." "
  let l:execstr .= b:latex_pdf_file."\\#src:".expand("%:p")
  let l:execstr .= ":".line(".").":0 &> /dev/null &"

  call xolox#misc#msg#debug(l:execstr)

  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>

" vim:foldmethod=marker:foldlevel=0

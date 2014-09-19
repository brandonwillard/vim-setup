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

"
" Reformat lines (getting the spacing correct) {{{
" From http://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim?lq=1
" doesn't really work; no support for $[$]...$[$]
fun! TeX_fmt()
    if (getline(".") != "")
    let save_cursor = getpos(".")
        let op_wrapscan = &wrapscan
        set nowrapscan
        let par_begin = '^\(%D\)\=\s*\($\|\\label\|\\begin\|\\end\|\\\[\|\\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
        let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\\[\|\\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
        norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
        let &wrapscan = op_wrapscan
    call setpos('.', save_cursor) 
    endif
endfun
" }}}

"function! NowebPySetup()
"  runtime! syntax/tex.vim
"  unlet b:current_syntax
"   
"  syntax include @nowebPy syntax/python.vim
"  syntax region nowebChunk start="^&lt;&lt;.*&gt;&gt;=" end="^@" contains=@nowebPy
"  "syntax region Sexpr  start="\\Sexpr{"  end="}" keepend
"  "hi Sexpr gui=bold guifg=chocolate2
"  syn match spellingException "\<\w*\d[\d\w]*\>"      transparent contained containedin=pythonComment,python.*String contains=@NoSpell
"  syn match spellingException "\<\(\u\l*\)\{2,}\>"    transparent contained containedin=pythonComment,python.*String contains=@NoSpell
"  syn match spellingException "\<\(\l\+\u\+\)\+\l*\>" transparent contained containedin=pythonComment,python.*String contains=@NoSpell
"  syn match spellingException "\S*[/\\_`]\S*"         transparent contained containedin=pythonComment,python.*String contains=@NoSpell
"   
"  let b:current_syntax="noweb"
"endfunction

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

  au filetype python setl iskeyword+=_

  au filetype tex 
       \ nmap Q :call TeX_fmt()<CR>
  "    \ setl makeprg=pdflatex\ -shell-escape\ % | 
  "    \ setl autoindent |
  "    \ setl spell |
  "    \ setl textwidth=80 |
  "    \ setl formatoptions+=t |
  "    "\ let b:tex_flavor |
  "    \ :compiler tex

  au! BufRead,BufNewFile *.texw setfiletype noweb |
    \ let noweb_backend="tex"      |
    \ let noweb_language="python"  |
    \ nnoremap <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython \|\| python")<CR>
    "\ call NowebPySetup() |

  au! BufRead,BufNewFile *.Pnw,*.pnw setfiletype noweb |
    \ let noweb_backend="markdown" |
    \ let noweb_language="python"  |
    \ nnoremap <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython \|\| python")<CR>
    "\ call NowebPySetup() |


  "
  " Setup Vimux for specific interactive sessions
  "
  " remove nocorrect if you're not using zshell (it stops the input
  " requirement when/if ipython doesn't exist)
  au filetype python 
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython \|\| python")<CR>
  au filetype scala 
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("scala")<CR>
  au filetype matlab 
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("matlab -nodisplay")<CR>
  au filetype haskell 
        \ setlocal formatoptions+=croql |
        \ nnoremap <LocalLeader>tr :call VimuxRunCommand("ghci --interactive")<CR>

augroup END




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


"nmap Q :call TeX_fmt()<CR> 
"setl autoindent
"setl spell
"setl textwidth=80
"setl formatoptions+=t
"let b:tex_flavor
"compiler tex
setl formatoptions+=croql
setl iskeyword+=_,.,-
setl makeprg=make\ %:gs?tex?pdf?:t
"setl makeprg=pdflatex\ -shell-escape\ %  

"let g:Tex_UseMakefile=1
"TexLet g:Tex_CompileRule_cont='make'
"let maplocalleader = mapleader
" make start-stop block out of the previous word
"imap <buffer> <LocalLeader>tb \begin<Cr>\end<Cr><Esc>4bhdiw$pj$pO
imap <buffer> [[ 		\begin{
imap <buffer> ]]		<Plug>LatexCloseCurEnv
nmap <buffer> <F5>		<Plug>LatexChangeEnv
vmap <buffer> <F7>		<Plug>LatexWrapSelection
vmap <buffer> <S-F7>		<Plug>LatexEnvWrapSelection
imap <buffer> (( 		\eqref{



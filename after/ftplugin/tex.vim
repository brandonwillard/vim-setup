
"setl autoindent
setl spell
"setl textwidth=80
"setl formatoptions+=t
setl sw=2
setl conceallevel=0

" remove these annoying latex-box mappings
"iunmap <buffer> [[
"iunmap <buffer> ]]
"imap <buffer> <LocalLeader>[[ 		\begin{
"imap <buffer> <LocalLeader>]]		<Plug>LatexCloseCurEnv
"nmap <buffer> <LocalLeader>ec		<Plug>LatexChangeEnv
"vmap <buffer> <LocalLeader>ws		<Plug>LatexWrapSelection
"vmap <buffer> <LocalLeader>ew		<Plug>LatexEnvWrapSelection
"imap <buffer> <LocalLeader>(( 		\eqref{

" section jumping
noremap <buffer> <silent> <Leader>gn :<c-u>call TexJump2Section( v:count1, '' )<CR>
noremap <buffer> <silent> <Leader>gN :<c-u>call TexJump2Section( v:count1, 'b' )<CR>
function! TexJump2Section( cnt, dir )
  let i = 0
  let pat = '^\s*\\\(part\|chapter\|\(sub\)*section\|paragraph\)\>\|\%$\|\%^'
   let flags = 'W' . a:dir
   while i < a:cnt && search( pat, flags ) > 0
     let i = i+1
   endwhile
   let @/ = pat
 endfunction

let b:thisaux = findfile(expand("%:r:t").".aux", "**4;")
let b:LatexBox_build_dir = fnamemodify(b:thisaux, ":p:h")
let b:build_dir = fnamemodify(b:thisaux, ":p:h")
let b:LatexBox_jobname = fnamemodify(b:thisaux, ":p:r")

"
" Some basic synctex functionality for use with
" qpdfview.
"
" The external sync command looks like:
" qpdfview --unique foobar.pdf#src:foobar.tex:42:0
"
function! SyncTexForward()
  if !exists('b:thispdf')
    let b:thispdf = findfile(expand("%:r:t").".pdf", "**4;")
  endif
  let l:execstr = "!qpdfview --unique ".b:thispdf."\\#src:".expand("%:p").":".line(".").":0 &> /dev/null &"
  silent exec l:execstr | redraw!
endfunction

nmap <Leader>f :call SyncTexForward()<CR>

compiler tex



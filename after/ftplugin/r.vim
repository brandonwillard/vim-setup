
setl formatoptions+=croql
setl iskeyword+=_,.

" could check first:
"if exists(':RDSendSelection')
"...
"endif

" FIXME: nvim-plugin needs these before it creates maps; otherwise
" it won't create the endpoint <Plug>'s.  we're gonna force it to 
" load them now, but this isn't really an extensible approach.
vmap <buffer> <LocalLeader>th <Plug>RHelp
nmap <buffer> <LocalLeader>th <Plug>RHelp
 
vmap <buffer> <LocalLeader>to <Plug>RObjectStr
nmap <buffer> <LocalLeader>to <Plug>RObjectStr

vmap <buffer> <LocalLeader>ts <Plug>RSendSelection
nmap <buffer> <LocalLeader>tl <Plug>RSendLine
nmap <buffer> <LocalLeader>tr <Plug>RStart
vmap <buffer> <LocalLeader>tr <Plug>RStart
nmap <buffer> <LocalLeader>tq <Plug>RClose
vmap <buffer> <LocalLeader>tq <Plug>RClose

call RCreateStartMaps()
call RCreateEditMaps()
call RCreateSendMaps()
call RControlMaps()


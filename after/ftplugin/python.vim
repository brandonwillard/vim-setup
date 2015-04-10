
setl tabstop=4
setl softtabstop=4
setl shiftwidth=4
setl expandtab
setl iskeyword+=_

"
" Setup Vimux for specific interactive sessions
"
" remove nocorrect if you're not using zshell (it stops the input
" requirement when/if ipython doesn't exist)
nnoremap <buffer> <LocalLeader>tr :call VimuxRunCommand("nocorrect ipython --matplotlib \|\| python")<CR> 
nnoremap <buffer> <LocalLeader>td :call VimuxRunCommand("nocorrect ipython --pydb --matplotlib \|\| python")<CR> 



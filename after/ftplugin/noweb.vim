
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
 
 
 


execute "syntax include @Code syntax/" . noweb_language . ".vim"
" add support for inline code
syntax match nowebEndInline "}" contained
syntax match nowebBeginInline "\Sexpr{" contained
syntax region nowebrInline start="\Sexpr{" end="}" contains=@Code,nowebBeginInline,nowebEndInline keepend

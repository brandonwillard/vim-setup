
if b:current_syntax != "texw"
  finish
endif

execute "syntax include @Code syntax/" . noweb_language . ".vim"
" add support for inline code
syntax match texwEndInline "%>" contained
syntax match texwBeginInline "<%" contained
syntax region texwrInline start="<%" end="%>" contains=@Code,texwBeginInline,texwEndInline keepend



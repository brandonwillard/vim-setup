
if exists("b:did_texw_settings")
  finish
endif

let b:did_texw_settings = 1

" these are reset when noweb syntax is loaded, so these
" settings are in texw's syntax file after loading noweb.

" noweb syntax file reads these as globals
let noweb_backend="tex"
let noweb_language="python"

" TODO: need to get multi-filetypes working
runtime after/ftplugin/noweb-tweaks.vim

" OK, here's a hack: 
" First, we load the standard tex settings,
" save some key option values in local variables,
" then we do the same for Python.
" Now, we can create functions that check the
" cursor location to determine which settings to use.
"
" FIXME: Lame that we have to manually load and list out the settings
" manually for each filetype.
" TODO: generalize this and add to a generic noweb after/ file
" (noweb-tweaks?).
" TODO: what about the `b:undo_ftplugin` and `b:undo_indent` variables?
" Looks like we could generate the `options_list` from that, no?
" TODO: what about syntax files?  looks like `iskeyword` doesn't work
" because of that.
"
" The OnSyntaxChange plugin (http://www.vim.org/scripts/script.php?script_id=4085)
" provides the mechanism for triggering these changes.
call OnSyntaxChange#Install('NowebCode', 'codeChunk', 1, 'a')

autocmd User SyntaxNowebCodeEnterA unsilent call SetCodeSettings("python")
autocmd User SyntaxNowebCodeLeaveA unsilent call SetCodeSettings("tex") 

let b:noweb_options_list = ["indentexpr", "indentkeys", "foldexpr", "formatexpr", "includeexpr", "foldtext", "comments", "commentstring", "formatoptions", "iskeyword", "cinkeys", "softtabstop", "shiftwidth", "tabstop"]

" extra hack for YouCompleteMe
let b:tex_omnifunc = 'youcompleteme#OmniComplete'
let b:python_omnifunc = 'youcompleteme#OmniComplete'

function! SetCodeSettings(lang)
  "echom "setting " . a:lang . " settings"
  for topt in b:noweb_options_list
    if exists("&".topt) 
      let l:exec_str = "let &".topt." = b:".a:lang."_".topt
      "echom l:exec_str
      execute(l:exec_str) 
    else
      echoerr topt . " is not an option!"
    endif
  endfor
endfunction

" TODO: what about the standard ftplugin files?
runtime! after/ftplugin/tex.vim after/ftplugin/tex_*.vim after/ftplugin/tex/*.vim
unlet! b:did_indent
runtime! indent/tex.vim indent/tex/*.vim 

for topt in b:noweb_options_list
  let b:tex_{topt} = eval("&" . topt)
endfor

runtime! ftplugin/python/*.vim after/ftplugin/python.vim after/ftplugin/python/*.vim
unlet! b:did_indent
runtime! indent/python.vim indent/python/*.vim 

for topt in b:noweb_options_list
  let b:python_{topt} = eval("&" . topt)
endfor

setl conceallevel=0

compiler texw


if exists("b:loaded_noweb_ftplugin")
  finish
endif
let b:loaded_noweb_ftplugin=1

""
" These Noweb* functions are adapted from the vim-r-plugin.
" 
" Chunk functions {{{
python << EOL

def parse_noweb_args(line):
    """ Parses a line for a noweb code chunk header
    and extracts the chunk keyword options.

    Chunk headers are delimited by
    ```
    <<chunk_name, option1=value1, ...>>=
    ...
    @
    ```
    This function returns `{"option1":"value1", ...}`.

    Parameters
    ==========
    line: str
        The noweb document line.

    Returns
    =======
    A `dict` with chunk option keywords and their values as strings.
    Otherwise, `None` when the line doesn't contain a valid code chunk header.
    """
    import re
    re_expr = re.compile(ur'^\s*?<<\w*?\s*?,?\s*?(.*)>>=\s*$')
    chunk_args = re.findall(re_expr, line)

    if len(chunk_args) == 0:
        return None

    import shlex
    sh = shlex.shlex(chunk_args[0], posix=True)
    sh.whitespace = ','
    sh.wordchars += '= '

    chunk_opts = filter(lambda x: '=' in x, sh)
    dict_res = dict(map(str.strip, val.split('=', 1)) for val in chunk_opts)
    return dict_res


def is_noweb_chunk_enabled(line, missing_true=True):
    """ Check if a noweb code chunk header is enabled
    for evaluate during the weaving phase.

    Keywords must start with 'eval' (case insensitive)
    and have values of 't', 'true' or '1' (case insensitive).

    Parameters
    ==========
    line: str
        The noweb document line.
    missing_true: boolean
        If `True`, then chunks without a matching eval option
        are evalued.

    Returns
    =======
    `True` if the line is a code chunk header that is enabled.
    """
    options_res = parse_noweb_args(line)

    if options_res is None:
      return False

    eval_options = filter(
        lambda x: x[0].lower().startswith('eval'),
        options_res.items())

    if len(eval_options) == 0:
      return missing_true

    eval_true = filter(
        lambda x: x[1].lower() in (
            't', 'true', '1'), eval_options)

    return any(eval_true)

EOL


function! NowebIsInCode(vrb)
  let chunkline = search("^<<", "bncW")
  let docline = search("^@", "bncW")
  if chunkline > docline && chunkline != line(".")
    return 1
  else
    if a:vrb
      echomsg "Not inside a code chunk."
    endif
    return 0
  endif
endfunction

function! NowebNextChunk() range
  let rg = range(a:firstline, a:lastline)
  let chunk = len(rg)
  for var in range(1, chunk)
    let i = search("^<<.*$", "nW")
    if i == 0
      echomsg "There is no next code chunk to go to."
      return
    else
      call cursor(i+1, 1)
    endif
  endfor
  return
endfunction

function! NowebPreviousChunk() range
    let rg = range(a:firstline, a:lastline)
    let chunk = len(rg)
    for var in range(1, chunk)
        let curline = line(".")
        if NowebIsInCode(0)
            let i = search("^<<.*$", "bnW")
            if i != 0
                call cursor(i-1, 1)
            endif
        endif
        let i = search("^<<.*$", "bnW")
        if i == 0
            call cursor(curline, 1)
            echomsg "There is no previous code chunk to go to."
            return
        else
            call cursor(i+1, 1)
        endif
    endfor
    return
endfunction
" }}}

" Chunk mappings {{{
nnoremap <buffer><silent> <Plug>(noweb-prev-chunk) :<C-U>call NowebPreviousChunk()<CR>
nnoremap <buffer><silent> <Plug>(noweb-next-chunk) :<C-U>call NowebNextChunk()<CR>

nmap <buffer> <LocalLeader>gN <Plug>(noweb-prev-chunk)
nmap <buffer> <LocalLeader>gn <Plug>(noweb-next-chunk)
" }}}

" The following is a hack to get 'dynamic' vim settings.  The settings
" will change depending on the cursor location.
"
" First, we load the standard noweb 'backend' settings,
" save some key option values in local variables,
" then we do the same for the noweb 'language'.
" Now, we can create functions that check the
" cursor location to determine which settings to use.
"
" FIXME: Lame that we have to manually load and list out the settings
" manually for each filetype.  Perhaps we could load these filetypes
" into a scratch buffer and get the values from there.
" TODO: what about the `b:undo_ftplugin` and `b:undo_indent` variables?
" Looks like we could generate the `options_list` from that, no?
" TODO: what about syntax files?  looks like `iskeyword` doesn't work
" because of that.
"
" The OnSyntaxChange plugin (http://www.vim.org/scripts/script.php?script_id=4085)
" provides the mechanism for triggering these changes.
call OnSyntaxChange#Install('NowebCode', 'nowebChunk', 1, 'a')

if !exists("b:noweb_language")
  " Handle multi-filetypes (in a very specific way):
  let b:noweb_language = split(&ft, '\.')[0] 
endif
if !exists("b:noweb_backend")
  " Handle multi-filetypes (in a very specific way):
  let b:noweb_backend = split(&ft, '\.')[1]  
endif

autocmd User SyntaxNowebCodeEnterA unsilent call SetCodeSettings(b:noweb_language)
autocmd User SyntaxNowebCodeLeaveA unsilent call SetCodeSettings(b:noweb_backend) 

let b:noweb_options_list = ["formatexpr", "includeexpr", "comments", "formatprg",
      \"commentstring", "formatoptions", "iskeyword", "cinkeys", "define", "conceallevel", 
      \"omnifunc", "keywordprg", "wildignore", "include", "textwidth", "cinoptions"]

" Append these option subsets
let s:noweb_fold_options = ["foldexpr", "foldtext", "foldmethod", "foldlevel", "foldopen"]
let s:noweb_indent_options = ["indentexpr", "indentkeys", "tabstop", "shiftwidth", 
      \"softtabstop", "expandtab", "copyindent", "preserveindent"]

let b:noweb_options_list += s:noweb_indent_options
let b:noweb_lang_settings = ''

function! SetCodeSettings(lang)
  " echom "setting " . a:lang . " settings"
  if b:noweb_lang_settings == '' || b:noweb_lang_settings != a:lang
    let b:noweb_lang_settings = a:lang
    try
      for topt in b:noweb_options_list
        let l:exec_str = "let &l:".topt." = b:noweb_".a:lang."_".topt
        "echom l:exec_str
        execute(l:exec_str) 
      endfor
    catch
      echoerr v:exception
    endtry
  endif
endfunction

" TODO: what about the standard ftplugin files?
" This might be a way to determine/automate the following:
" http://vim.wikia.com/wiki/Edit_configuration_files_for_a_filetype
"
for vlang in [b:noweb_backend, b:noweb_language]
  " try
    " Unset values:
    " NOTE: Could just do `:set all&`.
    for topt in b:noweb_options_list
      " echom "unsetting noweb_".vlang."_".topt."=".eval("&l:" . topt) 
      try
        execute(":set ".topt."&") 
      catch
        echoerr v:exception . ', topt=' . topt
      endtry
    endfor

    let &filetype=vlang

    for topt in b:noweb_options_list
      " echom "setting noweb_".vlang."_".topt."=".eval("&l:" . topt) 
      try
        let b:noweb_{vlang}_{topt} = eval("&l:" . topt)
      catch
        echoerr v:exception . ', topt=' . topt
      endtry
    endfor
  " catch
  "   echoerr v:exception
  " endtry
endfor
let &filetype='noweb'

"let g:ft_ignore_pat = s:old_ft_ignore_pat
"let did_load_filetypes = 1

" vim:foldmethod=marker:foldlevel=0

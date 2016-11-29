
"
" These Noweb* functions are adapted from the vim-r-plugin.
" 
if exists("b:loaded_noweb_ftplugin")
  finish
endif
let b:loaded_noweb_ftplugin=1

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

" REPL additions {{{

if !exists("b:loaded_repl")
  runtime! plugin/repl.vim
endif

function! NowebSendChunk(...)
    " Function that REPLs code chunks.
    " Takes two arguments:
    "     * First is a string value for which "down" signifies that
    "     the cursor is to jump to the next chunk after sending.
    "     * Second is an optional string that matches the first argument/option
    "     of the chunk (i.e. it IDs the chunk).
  let chunkline = -1
  let docline = -1
  let lines = ""
  if a:0 > 1
      let chunkline = search("^<<\\s*" . a:2, "bncw") + 1
      if chunkline < 2
          echomsg 'Chunk starting with "' . a:2 . '" not found.'
          return
      endif 
      "let docline = search("\\%>".string(chunkline-1)."l\\_.\\{-}\\_^@", "ncwe") - 1
      let endchk = "^@"
      let codelines = [getline(chunkline)]
      while getline(chunkline + 1) !~ endchk
          let chunkline += 1
          let codelines += [getline(chunkline)]
      endwhile
      let lines = join(codelines, "\n")
  else
      if NowebIsInCode(0) == 0
          echomsg "Not inside a code chunk."
          return
      endif
      let chunkline = search("^<<", "bncW") + 1
      let docline = search("^@", "ncW") - 1
      let lines = join(getline(chunkline, docline), "\n")
  endif
  call b:ReplSendString(lines)
  if a:1 == "down"
      call NowebNextChunk()
  endif
endfunction

"
" From the Nvim-R plugin
"
function! NowebSendFHChunk()
    let begchk = "^<<.*>>=\$"
    let endchk = "^@"

    let codelines = []
    let here = line(".")
    let curbuf = getline(1, "$")
    let idx = 0
    while idx < here
        let enabled = pyeval("is_noweb_chunk_enabled('".escape(curbuf[idx], "\\\"'")."')") 
        "if curbuf[idx] =~ begchk
        if enabled == 1
            let idx += 1
            while curbuf[idx] !~ endchk && idx < here
                let codelines += [curbuf[idx]]
                let idx += 1
            endwhile
        else
            let idx += 1
        endif
    endwhile

    let comblines = join(codelines, "\n")
    call b:ReplSendString(comblines)
endfunction



command! NowebSendChunkCmd call NowebSendChunk("stay") 
command! NowebSendFHChunkCmd call NowebSendFHChunk() 

nnoremap <buffer><silent> <Plug>(noweb-send-chunk) :<C-U>call NowebSendChunk("stay")<CR>
nnoremap <buffer><silent> <Plug>(noweb-send-fh-chunk) :<C-U>call NowebSendFHChunk()<CR>

nmap <buffer> <LocalLeader>tc <Plug>(noweb-send-chunk)
nmap <buffer> <LocalLeader>tC <Plug>(noweb-send-fh-chunk)

" Here's a little custom addition that runs a chunk with the
" name 'pweave_code'.  This can be used to run a weave/build
" command from Python within the REPL session (so that, for example, weaved chunk
" variables are exposed to the session).
nmap <buffer> <LocalLeader>tw :<C-U>call NowebSendChunk("stay", "pweave_code")<CR> 

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
" TODO: generalize this and add to a generic noweb after/ file
" (noweb-tweaks?).
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
      \"commentstring", "formatoptions", "iskeyword", "cinkeys", "define", 
      \"omnifunc", "keywordprg", "wildignore", "include", "textwidth", "cinoptions"]

" Append these option subsets
let s:noweb_fold_options = ["foldexpr", "foldtext", "foldmethod", "foldlevel", "foldopen"]
let s:noweb_indent_options = ["indentexpr", "indentkeys", "tabstop", "shiftwidth", 
      \"softtabstop", "expandtab", "copyindent", "preserveindent"]

let b:noweb_options_list += s:noweb_indent_options

function! SetCodeSettings(lang)
  "echom "setting " . a:lang . " settings"
  try
    for topt in b:noweb_options_list
      let l:exec_str = "let &".topt." = b:noweb_".a:lang."_".topt
      "echom l:exec_str
      execute(l:exec_str) 
    endfor
  catch
    echoerr v:exception
  endtry
endfunction

" TODO: what about the standard ftplugin files?
" This might be a way to determine/automate the following:
" http://vim.wikia.com/wiki/Edit_configuration_files_for_a_filetype
"
" FYI: Using tpope's `:Runtime` to load these, so we no longer
" need the surrounding `let/unlet` statements.
"
for vlang in [b:noweb_backend, b:noweb_language]
    "let s:old_ft_ignore_pat = g:ft_ignore_pat
    "let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\|'.&ft.'\|'.vlang.'\.'.&ft.'\)$' 

    "unlet! did_load_filetypes
    "unlet! b:did_indent
    "unlet! b:did_ftplugin
    try
      " let b:lang_runtimes = globpath(&rtp, "**/ftplugin/".vlang."*.vim", 0, 1, 0) 
      " let b:lang_runtimes += globpath(&rtp, "**/indent/".vlang."*.vim", 0, 1, 0) 
      " let b:lang_runtimes = uniq(sort(b:lang_runtimes))
      " let s:lang_runtimes = ["ftplugin/".vlang.".vim", 
      "             \" after/ftplugin/".vlang.".vim", 
      "             \" after/ftplugin/".vlang."_*.vim",
      "             \" after/ftplugin/".vlang."/*.vim",
      "             \" indent/".vlang.".vim", 
      "             \" indent/".vlang."/*.vim"]
      " let &filetype=none
      " execute "Runtime ".join(b:lang_runtimes, ' ')
      let &filetype=vlang

      for topt in b:noweb_options_list
          " echom "setting noweb_".vlang."_".topt."=".eval("&" . topt) 
          let b:noweb_{vlang}_{topt} = eval("&" . topt)
      endfor
    catch
      echoerr v:exception
    endtry
    "unlet! did_load_filetypes
    "unlet! b:did_indent
    "unlet! b:did_ftplugin
endfor
let &filetype='noweb'

"let g:ft_ignore_pat = s:old_ft_ignore_pat
"let did_load_filetypes = 1

" vim:foldmethod=marker:foldlevel=0

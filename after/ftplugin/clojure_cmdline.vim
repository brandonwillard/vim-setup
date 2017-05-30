if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! s:StartJupyterString()
  return "nocorrect jupyter-console --kernel clojure \|\| clojure"
endfunction

if executable("jupyter-console")
  let g:cmdline_app["clojure"] = s:StartJupyterString()
endif

function! ReplSendString_jup(lines)
  " TODO: Should provide generics for Jupyter.
  " Just for some background, you might see control/escape
  " sequences like `\x1b[200~` printed as `^[[200~`.  The
  " first part is, of course, the ESC control character
  " (ASCII: `^[`).  These exact control sequences are bracketed
  " paste modes in an xterm setting 
  " (see https://cirw.in/blog/bracketed-paste).
  " (check out this, too: http://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html)
  
  let expr_str = "\x1b[200~".join(add(a:lines, ''), b:cmdline_nl)."\x1b[201~\n"

  call VimCmdLineSendCmd(expr_str)

endfunction

let b:cmdline_app = "clojure"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = function("ReplSendString_jup")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "clojure"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

" reset vimcmdline settings for this filetype
call VimCmdLineSetApp("clojure")

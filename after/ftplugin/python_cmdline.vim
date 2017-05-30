if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! s:StartJupyterString()
  let python_version = system('python -V')
  " Remove nocorrect if you're not using zshell (it stops the input
  if python_version =~ '^Python 3\.\?'
    return "nocorrect jupyter-console --kernel python3 \|\| python"
  elseif python_version =~ '^Python 2\.\?'
    return "nocorrect jupyter-console --kernel python2 \|\| python"
  else
    return "nocorrect jupyter-console \|\| python"
  endif
endfunction

if executable("jupyter-console")
  let g:cmdline_app["python"] = s:StartJupyterString()
endif

function! ReplSendString_ipy(lines)
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

" command! PythonSendIPythonDebugLine :call VimCmdLineSendCmd('%debug -b ' . expand('%') . ':' . line('.'))

let b:cmdline_app = "python"
let b:cmdline_quit_cmd = "quit()"
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = function("ReplSendString_ipy")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "python"

exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

" reset vimcmdline settings for this filetype
call VimCmdLineSetApp("python")

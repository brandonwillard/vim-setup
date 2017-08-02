function! s:StartJupyterString()
  return "nocorrect jupyter-console --kernel clojure \|\| clojure"
endfunction

if executable("jupyter-console")
  let b:cmdline_app = s:StartJupyterString()
else
  let b:cmdline_app = "clojure"
endif

let b:cmdline_quit_cmd = "quit()"
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "clojure"


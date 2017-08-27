let b:cmdline_app = ""
if get(b:, "cmdline_jupyter", get(g:, "cmdline_jupyter", 0))
  let b:cmdline_app = g:StartJupyterString("clojure")
endif

if b:cmdline_app == ""
  let b:cmdline_app = "clojure"
endif

let b:cmdline_quit_cmd = "quit()"
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "clojure"


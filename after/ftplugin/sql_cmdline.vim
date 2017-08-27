
let b:cmdline_app = ""
if get(b:, "cmdline_jupyter", get(g:, "cmdline_jupyter", 0))
  let b:cmdline_app = g:StartJupyterString("postgres")
endif

if b:cmdline_app == ""
  let b:cmdline_app = "PGDATABASE=postgres psql"
  let b:cmdline_quit_cmd = '\q'
else 
  let b:cmdline_quit_cmd = 'quit()'
endif

let b:cmdline_nl = "\n"
let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "sql"

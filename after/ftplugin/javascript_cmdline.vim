let b:cmdline_app = "js"
let b:cmdline_quit_cmd = 'process.exit()'
let b:cmdline_nl = "\n"
let b:cmdline_source_fun = {arg -> function("ReplSendMultiline")(arg)}
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "javascript"

if !exists("g:cmdline_job")
    finish
endif

function! ReplGetSelection(curmode) range		
  "		
  " This function gets either the visually selected text,		or the current
  " <cWORD>.		
  "		
  if (a:firstline == 1 && a:lastline == line('$')) || a:curmode == "n"		
    return [expand('<cWORD>')]		
  endif		

  let [lnum1, col1] = getpos("'<")[1:2]		
  let end_pos = getpos("'>")		
  let [lnum2, col2] = end_pos[1:2]		
  let lines = getline(lnum1, lnum2)		
		
  let mode_offset = 1		
  if &selection == 'exclusive'		
    let mode_offset = 2		
  endif		
		
  let lines[-1] = lines[-1][:(col2 - mode_offset)]		
  let lines[0] = lines[0][col1 - 1:]		
		
  " Sends the cursor to the beginning of the last visual select		
  " line.  We probably want to leave the cursor at the end of the		
  " visually selected region instead.		
  "call cursor(lnum2, 1)		
  execute "normal! gv\<Esc>"		
  return lines
endfunction

if exists("b:cmdline_source_fun")
  command! -range -nargs=1 ReplSendSelectionCmd 
        \call b:cmdline_source_fun(ReplGetSelection(<f-args>)) 

  exe 'nnoremap <silent><buffer> ' . g:cmdline_map_send_selection . 
        \' :ReplSendSelectionCmd n<CR>'
  exe 'vnoremap <silent><buffer> '. g:cmdline_map_send_selection . 
        \' :ReplSendSelectionCmd v<CR>'
endif

" vim:foldmethod=marker:foldlevel=0

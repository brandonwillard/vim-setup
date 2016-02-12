
" this doesn't work after the plugin has loaded
let g:tmux_navigator_no_mappings = 1
silent! nunmap <C-h>
silent! nunmap <C-j>
silent! nunmap <C-k>
silent! nunmap <C-l>
nnoremap <silent> <C-W>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-W>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-W>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-W>l :TmuxNavigateRight<cr>
nnoremap <silent> <C-W>\ :TmuxNavigatePrevious<cr>

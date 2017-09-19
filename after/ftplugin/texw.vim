setl conceallevel=0

if exists('b:neomake_tex_pdfmake_maker')
  let b:neomake_texw_noweb_pdfmake_maker = b:neomake_tex_pdfmake_maker
endif

if exists('b:neomake_tex_rubberinfo_maker')
  let b:neomake_texw_noweb_rubberinfo_maker = b:neomake_tex_rubberinfo_maker
endif

if exists('b:neomake_tex_clean_maker')
  let b:neomake_texw_noweb_clean_maker = b:neomake_tex_clean_maker
endif

if exists('b:neomake_tex_enabled_makers')
  let b:neomake_texw_noweb_enabled_makers = b:neomake_tex_enabled_makers
endif

let g:texw_latex_project_let_vars = g:latex_project_let_vars

if has_key(g:plugs, 'vim-noweb')
  
  let s:kernel_name = GetPythonVersion()

  if executable('jupyter-kernelspec')
    let s:kernels_info = json_decode(system('jupyter-kernelspec list --json'))
    if !has_key(s:kernels_info['kernelspecs'], s:kernel_name)
      echoerr printf('Could not find Jupyter kernel for %s', s:kernel_name) 
    endif
  endif

  " There's also: noweb_format_opts, noweb_weave_docmode
  let s:noweb_format_opts = { 'width': '\textwidth',
        \ 'figfmt': '.pdf', 'savedformats': ['.pdf'] }

  let g:texw_latex_project_let_vars = extend(g:texw_latex_project_let_vars, { 
      \   'b:noweb_weave_language': s:kernel_name,
      \   'b:noweb_weave_backend': 'tex',
      \   'b:noweb_format_opts': s:noweb_format_opts,
      \   'b:noweb_weave_formatter': 'texmintedpandoc',
      \   'b:noweb_figures_dir': '{project}/figures',
      \   'b:noweb_backend_src_dir': '{project}/src/tex'
      \ })
endif

let g:projectionist_heuristics['src/python/&output/'] = { 
      \ 'src/python/*.texw': { 
      \ 'let': g:texw_latex_project_let_vars,
      \ 'alternate': 'src/tex/{}.tex',
      \ 'type': 'source' 
      \ }} 

" let g:projectionist_heuristics['src/tex/&output/']['alternate'] = 'src/python/{}.texw'

" vim:foldmethod=marker:foldlevel=0

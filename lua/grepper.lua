vim.api.nvim_exec([[

  function GetAbsoluteForderPath()
    return substitute(expand('%:p:h'), getcwd(), '', '')
  endfunction


  function GetAbsolutePath()
    return substitute(expand('%"d'), getcwd(), '', '')
  endfunction

  let g:grepper               = {}
  let g:grepper.tools         = ['rg', 'ag', 'git']
  let g:grepper.jump          = 1
  let g:grepper.next_tool     = '<leader>nt'
  let g:grepper.simple_prompt = 1
  let g:grepper.quickfix      = 0

  nnoremap <silent> <leader>GA :Grepper -cword -noprompt<CR><CR>
  nnoremap <silent> <leader>GD :Grepper -cword -noprompt -cd .<C-R>=GetAbsoluteForderPath()<CR><CR><CR>

]], false)


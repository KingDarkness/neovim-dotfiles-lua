vim.api.nvim_exec(
    [[
  function GetAbsoluteForderPath()
    return substitute(expand('%:p:h'), getcwd(), '', '')
  endfunction


  function GetAbsolutePath()
    return substitute(expand('%"d'), getcwd(), '', '')
  endfunction

  let g:grepper               = {}
  let g:grepper.tools         = ['ag']

  nnoremap <silent> <leader>SA :Grepper -cword -noprompt<CR><CR>
  nnoremap <silent> <leader>S :Grepper <CR><CR>
  nnoremap <silent> <leader>SD :Grepper -cword -noprompt -cd .<C-R>=GetAbsoluteForderPath()<CR><CR><CR>


  nnoremap <Leader>RA :let @s=expand('<cword>')<CR> :Grepper -cword -noprompt<CR> :cfdo %s/<C-r>s//g \| update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
  nnoremap <Leader>RD :let @s=expand('<cword>')<CR> :Grepper -cword -noprompt -cd .<C-R>=GetAbsoluteForderPath()<CR><CR> :cfdo %s/<C-r>s//g \| update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
]],
    false
)

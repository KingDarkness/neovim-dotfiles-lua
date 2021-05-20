vim.api.nvim_exec([[
  if exists('$SHELL')
    set shell=$SHELL
  else
    set shell=/bin/sh
  endif

  let test#strategy='neovim'

  let test#neovim#term_position = "topleft"
  let test#neovim#term_position = "vert"
  let test#neovim#term_position = "vert botright 100"

  function! DockerTransform(cmd) abort
    let docker_container_name = '3t-product'
    let phpunit_xml = '/var/www/html/phpunit.xml'
    return 'docker exec ' . docker_container_name . ' phpdbg -qrr ' . a:cmd . ' -c ' . phpunit_xml . ' --debug --colors=always'
  endfunction

  let g:test#custom_transformations = {'docker': function('DockerTransform')}
  let g:test#transformation = 'docker'

  nmap <silent> <leader>tm :TestNearest<cr>
  nmap <silent> <leader>tf :TestFile<cr>
  nmap <silent> <leader>ta :TestSuite<cr>
  nmap <silent> <leader>tp :TestLast<cr>
]], false)

local M = {}

function M.setup()
    vim.api.nvim_exec(
        [[
        if exists('$SHELL')
        set shell=$SHELL
        else
        set shell=/bin/sh
        endif

        let test#strategy='neovim'

        let g:test#neovim#start_normal = 1
        let test#neovim#term_position = "topleft"
        let test#neovim#term_position = "vert"
        let test#neovim#term_position = "vert botright 100"
        let g:docker_container_name = ''

        function! DoTest(type)
            if g:docker_container_name == ''
                let name = input('Enter docker container name: ')
                let g:docker_container_name = name
                redraw
            endif

            if a:type == "TestNearest"
                :TestNearest
            elseif a:type == "TestFile"
                :TestFile
            elseif a:type == "TestSuite"
                :TestSuite
            else
                :TestLast
            endif
        endfunction

        function! DockerTransform(cmd) abort
            let phpunit_xml = '/var/www/html/phpunit.xml'
            return 'docker exec ' . g:docker_container_name . ' phpdbg -qrr ' . a:cmd . ' -c ' . phpunit_xml . ' --debug --colors=always'
        endfunction

        let g:test#custom_transformations = {'docker': function('DockerTransform')}
        let g:test#transformation = 'docker'

        nmap <silent> <leader>tm :call DoTest("TestNearest")<cr>
        nmap <silent> <leader>tf :call DoTest("TestFile")<cr>
        nmap <silent> <leader>ta :call DoTest("TestSuite")<cr>
        nmap <silent> <leader>tp :call DoTest("TestLast")<cr>
    ]],
        false
    )
end

return M

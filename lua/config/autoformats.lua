local M = {}
local g = vim.g -- a table to access global variables
local util = require("formatter.util")

function M.setup()
    require("formatter").setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
            -- Formatter configurations for filetype "lua" go here
            -- and will be executed in order
            lua = { require("formatter.filetypes.lua").stylua },
            php = {
                function()
                    return {
                        exe = "php-cs-fixer",
                        args = {
                            "fix",
                            "-q",
                            "--using-cache=no",
                            "--config="
                                .. vim.fn.stdpath("config")
                                .. "/plugins/formatter/php-cs-fixer/.php-cs-fixer.dist.php",
                        },
                        stdin = false,
                        ignore_exitcode = true,
                    }
                end,
            },
            css = { require("formatter.filetypes.css").prettier },
            scss = { require("formatter.filetypes.css").prettier },
            html = { require("formatter.filetypes.html").prettier },
            javascript = { require("formatter.filetypes.javascript").prettier },
            javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
            typescript = { require("formatter.filetypes.typescript").prettier },
            typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
            vue = { require("formatter.filetypes.vue").prettier },
            yaml = { require("formatter.filetypes.yaml").prettier },
            json = { require("formatter.filetypes.json").prettier },
            markdown = { require("formatter.filetypes.markdown").prettier },
            sh = { require("formatter.filetypes.sh").shfmt },
            -- Use the special "*" filetype for defining formatter configurations on
            -- any filetype
            ["*"] = {
                -- "formatter.filetypes.any" defines default configurations for any
                -- filetype
                require("formatter.filetypes.any").remove_trailing_whitespace,
            },
        },
    })
    vim.api.nvim_exec(
        [[
      augroup fmt
        autocmd!
        autocmd BufWritePost * FormatWrite
      augroup END
    ]],
        false
    )
end

return M

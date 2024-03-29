local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "javascript",
            "html",
            "css",
            "bash",
            "lua",
            "json",
            "python",
            "dart",
            "dockerfile",
            "php",
            "toml",
            "typescript",
            "vue",
            "yaml",
            "tsx",
            "markdown",
            "markdown_inline",
        },
        highlight = {
            enable = true,
            use_languagetree = true,
        },
        indent = {
            enable = true,
        },
        rainbow = {
            enable = true,
            max_file_lines = 1000,
            extended_mode = true,
        },
        enable_autocmd = false,
        languages = {
            vue = {
                __default = "// %s",
                comment = "// %s",
                css_style = "/* %s */",
                html = "<!-- %s -->",
            },
        },
        autotag = {
            enable = true,
            filetypes = { "html", "xml" },
        },
    })
end

return M

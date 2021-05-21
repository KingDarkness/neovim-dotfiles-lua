local g = vim.g -- a table to access global variables

g.neoformat_only_msg_on_error = 1
-- open to debug
-- g.neoformat_verbose = 1

g.shfmt_opt = "-ci"

g.neoformat_php_phpcsfix = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/php-cs-fixer/vendor/bin/php-cs-fixer",
    args = {"fix", "-q", "--using-cache=no"},
    replace = 1
}

g.neoformat_enabled_php = {"phpcsfix"}

g.neoformat_javascript_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write", "--config .prettierrc.json"},
    replace = 1
}

g.neoformat_enabled_javascript = {"prettier"}

g.neoformat_typescript_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write", "--config .prettierrc.json"},
    replace = 1
}

g.neoformat_enabled_typescript = {"prettier"}

g.neoformat_vue_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write", "--config .prettierrc.json"},
    replace = 1
}

g.neoformat_enabled_vue = {"prettier"}

g.neoformat_html_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write"},
    replace = 1
}

g.neoformat_enabled_html = {"prettier"}

g.neoformat_json_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write"},
    replace = 1
}

g.neoformat_enabled_json = {"prettier"}

g.neoformat_less_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write"},
    replace = 1
}

g.neoformat_enabled_less = {"prettier"}

g.neoformat_css_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write"},
    replace = 1
}

g.neoformat_enabled_css = {"prettier"}

g.neoformat_scss_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write"},
    replace = 1
}

g.neoformat_enabled_scss = {"prettier"}

g.neoformat_markdown_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write"},
    replace = 1
}

g.neoformat_enabled_markdown = {"prettier"}

g.neoformat_yaml_prettier = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/prettier/node_modules/.bin/prettier",
    args = {"--write"},
    replace = 1
}

g.neoformat_enabled_yaml = {"prettier"}

g.neoformat_lua_luafmt = {
    exe = vim.fn.stdpath("config") .. "/plugins/formatter/lua-fmt/node_modules/.bin/luafmt",
    args = {"-w replace"},
    replace = 1
}

g.neoformat_enabled_lua = {"luafmt"}

-- auto format on save
vim.api.nvim_exec([[
  augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
  augroup END
]], false)

local M = {}

function M.on_attach(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", opts)
    buf_set_keymap("n", "gD", "<Cmd>Lspsaga peek_definition<CR>", opts)
    buf_set_keymap("n", "<F12>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    -- buf_set_keymap("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
    -- buf_set_keymap("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
    buf_set_keymap("n", "<F10>", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- buf_set_keymap("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "ca", "<cmd>Lspsaga code_action<cr>", opts)
    buf_set_keymap("x", "ca", ":<c-u>Lspsaga code_action<cr>", opts)
    buf_set_keymap("n", "<leader>o", "<cmd>Lspsaga outline<cr>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.server_capabilities.documentRangeFormattingProvider then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

function M.setup(lsp_installer)
    lsp_installer.setup({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    })

    -- nvim-cmp supports additional completion capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
                on_attach = M.on_attach,
                capabilities = capabilities,
            })
        end,
        ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
                on_attach = M.on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
        ["intelephense"] = function()
            require("lspconfig").intelephense.setup({
                on_attach = M.on_attach,
                capabilities = capabilities,
                settings = {
                    intelephense = {
                        environment = { phpVersion = "8.1" },
                        stubs = {
                            "apache",
                            "bcmath",
                            "bz2",
                            "calendar",
                            "com_dotnet",
                            "Core",
                            "ctype",
                            "curl",
                            "date",
                            "dba",
                            "dom",
                            "enchant",
                            "exif",
                            "FFI",
                            "fileinfo",
                            "filter",
                            "fpm",
                            "ftp",
                            "gd",
                            "gettext",
                            "gmp",
                            "hash",
                            "iconv",
                            "imap",
                            "intl",
                            "json",
                            "ldap",
                            "libxml",
                            "mbstring",
                            "meta",
                            "mysqli",
                            "oci8",
                            "odbc",
                            "openssl",
                            "pcntl",
                            "pcre",
                            "PDO",
                            "pdo_ibm",
                            "pdo_mysql",
                            "pdo_pgsql",
                            "pdo_sqlite",
                            "pgsql",
                            "Phar",
                            "posix",
                            "pspell",
                            "readline",
                            "Reflection",
                            "session",
                            "shmop",
                            "SimpleXML",
                            "snmp",
                            "soap",
                            "sockets",
                            "sodium",
                            "SPL",
                            "sqlite3",
                            "standard",
                            "superglobals",
                            "sysvmsg",
                            "sysvsem",
                            "sysvshm",
                            "tidy",
                            "tokenizer",
                            "xml",
                            "xmlreader",
                            "xmlrpc",
                            "xmlwriter",
                            "xsl",
                            "Zend OPcache",
                            "zip",
                            "zlib",
                            "wordpress",
                            "woocommerce",
                            "acf-pro",
                            "wordpress-globals",
                            "wp-cli",
                            "genesis",
                        },
                        files = { maxSize = 5000000 },
                    },
                },
            })
        end,
    })

    -- replace the default lsp diagnostic letters with prettier symbols
    vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsDefaultError" })
    vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsDefaultWarning" })
    vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsDefaultInformation" })
    vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsDefaultHint" })

    vim.lsp.set_log_level(vim.log.levels.ERROR)
end

return M

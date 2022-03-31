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
    local opts = {noremap = true, silent = true}

    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
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
    buf_set_keymap("x", "ca", ":<c-u>Lspsaga range_code_action<cr>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    require "lsp_signature".on_attach({hint_prefix = " ", use_lspsaga = true})
end

function M.setup(lsp_installer)
    lsp_installer.settings(
        {
            ui = {
                icons = {
                    server_installed = "✓",
                    server_pending = "➜",
                    server_uninstalled = "✗"
                }
            }
        }
    )

    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    lsp_installer.on_server_ready(
        function(server)
            local opts = {
                on_attach = M.on_attach,
                capabilities = capabilities
            }

            -- (optional) Customize the options passed to the server
            -- if server.name == "tsserver" then
            --     opts.root_dir = function() ... end
            -- end
            --
            if server.name == "sumneko_lua" then
                opts.settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"}
                        }
                    }
                }
            end

            if server.name == "intelephense" then
                opts.settings = {
                    intelephense = {
                        environment = {phpVersion = "8.1"},
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
                            "genesis"
                        },
                        files = {maxSize = 5000000}
                    }
                }
            end

            -- This setup() function is exactly the same as lspconfig's setup function.
            -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            server:setup(opts)
        end
    )

    -- replace the default lsp diagnostic letters with prettier symbols
    vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
    vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
    vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
    vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
end

return M

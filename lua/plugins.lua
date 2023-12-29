local M = {}

function M.setup()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        { "nvim-lua/plenary.nvim" },
        { "nvim-lua/popup.nvim" },
        {
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
            end,
        },
        {
            "nvim-tree/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup({ default = true })
            end,
        },
        -- highlighting
        {
            "nvim-treesitter/nvim-treesitter",
            name = "nvim-treesitter",
            event = "BufRead",
            build = ":TSUpdate",
            dependencies = {
                "p00f/nvim-ts-rainbow",
                "JoosepAlviste/nvim-ts-context-commentstring",
                {
                    "windwp/nvim-ts-autotag",
                    ft = {
                        "html",
                        "javascript",
                        "typescript",
                        "javascriptreact",
                        "typescriptreact",
                        "svelte",
                        "vue",
                        "tsx",
                        "jsx",
                        "rescript",
                        "xml",
                        "php",
                        "markdown",
                        "glimmer",
                        "handlebars",
                        "hbs",
                    },
                    config = function()
                        require("nvim-ts-autotag").setup({ enable = true })
                    end,
                },
                {
                    "windwp/nvim-autopairs",
                    build = "make",
                    config = function()
                        require("nvim-autopairs").setup({})
                    end,
                },
            },
            config = function()
                require("config.treesitter").setup()
            end,
        },
        -- lsp stuff
        {
            "williamboman/mason.nvim",
            dependencies = {
                "williamboman/mason-lspconfig.nvim",
            },
            build = ":MasonUpdate",
        },
        {
            "mhartington/formatter.nvim",
            config = function()
                require("config.autoformats").setup()
            end,
        },
        {
            "neovim/nvim-lspconfig",
            name = "nvim-lspconfig",
            dependencies = { "nvim-treesitter" },
            config = function()
                require("config.lsp").setup(require("mason"))
            end,
        },
        {
            "folke/trouble.nvim",
            dependencies = { "nvim-lspconfig" },
            event = "VimEnter",
            config = function()
                require("config.troubles").setup()
            end,
        },
        {
            "akinsho/flutter-tools.nvim",
            event = "BufWinEnter",
            ft = "dart",
            dependencies = { "nvim-lspconfig" },
            config = function()
                require("flutter-tools").setup({
                    widget_guides = {
                        enabled = false,
                    },
                    fvm = true,
                    experimental = {
                        -- map of feature flags
                        lsp_derive_paths = true, -- EXPERIMENTAL: Attempt to find the user's flutter SDK
                    },
                    outline = {
                        open_cmd = "30vnew", -- command to use to open the outline buffer
                    },
                    dev_log = {
                        enabled = true,
                        open_cmd = "tabedit", -- command to use to open the log buffer
                    },
                    lsp = {
                        on_attach = require("config.lsp").on_attach,
                    },
                })
            end,
        },
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "ray-x/cmp-treesitter",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lsp-signature-help",
            },
            config = function()
                require("config.cmp-completion").setup()
            end,
        },
        {
            "glepnir/lspsaga.nvim",
            dependencies = { "nvim-lspconfig" },
            branch = "main",
            event = "LspAttach",
            config = function()
                require("config.lsp-saga").setup()
            end,
        },
        "onsails/lspkind-nvim",
        {
            "j-hui/fidget.nvim",
            dependencies = { "nvim-lspconfig" },
            event = "VimEnter",
            branch = "legacy",
            config = function()
                require("fidget").setup()
            end,
        },
        -- snippet support
        {
            "hrsh7th/cmp-vsnip",
            dependencies = {
                "nvim-cmp",
                "hrsh7th/vim-vsnip",
                {
                    "hrsh7th/vim-vsnip-integ",
                    dependencies = { "vim-vsnip" },
                },
                {
                    "rafamadriz/friendly-snippets",
                    dependencies = { "cmp-vsnip" },
                },
            },
        },
        -- file managing , picker, theme, etc
        {
            "kyazdani42/nvim-tree.lua",
            event = "BufWinEnter",
            config = function()
                require("config.tree").setup()
            end,
        },
        -- "nathom/filetype.nvim")
        -- use "norcalli/nvim-base16.lua"
        "KingDarkness/nvim-base16.lua",
        {
            "hoob3rt/lualine.nvim",
            dependencies = { "nvim-treesitter" },
            config = function()
                require("config.statusline").setup()
            end,
        },
        {
            "akinsho/nvim-bufferline.lua",
            dependencies = { "nvim-treesitter" },
            event = "BufReadPre",
            version = "v3.*",
            config = function()
                require("config.top-bufferline").setup()
            end,
        },
        {
            "norcalli/nvim-colorizer.lua",
            event = "BufWinEnter",
            config = function()
                require("colorizer").setup()
            end,
        },
        {
            "nvim-telescope/telescope.nvim",
            event = "VimEnter",
            dependencies = {
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
                { "nvim-telescope/telescope-media-files.nvim" },
                { "nvim-telescope/telescope-ui-select.nvim" },
            },
            config = function()
                require("config.telescopes").setup()
            end,
        },
        {
            "ThePrimeagen/harpoon",
            event = "VimEnter",
            config = function()
                require("config.harpoon").setup()
            end,
        },
        {
            "lukas-reineke/indent-blankline.nvim",
            branch = "master",
            config = function()
                require("config.blankline").setup()
            end,
        },
        -- git
        {
            "lewis6991/gitsigns.nvim",
            dependencies = { "apzelos/blamer.nvim" },
            config = function()
                require("config.gitsign").setup()
            end,
        },
        -- other
        {
            "907th/vim-auto-save",
            event = "VimEnter",
            config = function()
                vim.g.auto_save = 1
                vim.g.auto_save_events = { "InsertLeave" }
                -- g.auto_save_events = ['InsertLeave', 'TextChanged']
                vim.g.auto_save_write_all_buffers = 1
            end,
        },

        {
            "junegunn/vim-easy-align",
            event = "BufReadPost",
            config = function()
                vim.api.nvim_exec(
                    [[
                  xmap <leader>a <Plug>(EasyAlign)
                  nmap <leader>a <Plug>(EasyAlign)
                ]],
                    false
                )
            end,
        },
        { "chaoren/vim-wordmotion", event = "BufWinEnter" },
        {
            "vim-test/vim-test",
            event = "BufWinEnter",
            config = function()
                require("config.test").setup()
            end,
        },
        "tpope/vim-sleuth",
        {
            "editorconfig/editorconfig-vim",
            config = function()
                vim.g.EditorConfig_exec_path = "editorconfig"
                vim.g.EditorConfig_core_mode = "external_command"
            end,
        },
        { "alvan/vim-closetag", event = "BufWinEnter", ft = { "html", "php", "vue", "jsx", "xhtml", "htm", "jsx" } },
        {
            "karb94/neoscroll.nvim",
            event = "BufWinEnter",
            config = function()
                require("neoscroll").setup() -- smooth scroll
            end,
        },
        {
            "folke/which-key.nvim",
            config = function()
                require("config.whichkey").setup()
            end,
        },
        { "tweekmonster/startuptime.vim", cmd = "StartupTime" },
        { "schickling/vim-bufonly", event = "VimEnter" },
        { "tpope/vim-surround", event = "BufWinEnter" },
        { "mechatroner/rainbow_csv", event = "BufWinEnter", ft = "csv" },
        -- doc generate
        {
            "kkoomen/vim-doge",
            build = ":call doge#install()",
            event = "VimEnter",
        },
        -- comment
        {
            "folke/todo-comments.nvim",
            config = function()
                require("todo-comments").setup()
            end,
        },
        {
            "numToStr/Comment.nvim",
            keys = { "gc", "gb", "gcc", "gbc" },
            config = function()
                require("Comment").setup({
                    mappings = { extra = true },
                })
            end,
        },
        -- workspace & dashboard
        {
            "rmagatti/session-lens",
            dependencies = { "rmagatti/auto-session" },
            config = function()
                require("config.sessions").setup()
            end,
        },
        -- search & replace
        {
            "windwp/nvim-spectre",
            event = "VimEnter",
            config = function()
                require("config.spectres").setup()
            end,
        },
        -- html
        {
            "mattn/emmet-vim",
            ft = { "html", "css", "php", "vue" },
            event = "VimEnter",
            config = function()
                vim.g.user_emmet_leader_key = ","
                vim.g.user_emmet_mode = "i"
                vim.g.user_emmet_install_global = 0

                vim.api.nvim_exec(
                    [[
                  autocmd FileType html,css,php,vue EmmetInstall
                ]],
                    false
                )
            end,
        },
    })
end

return M

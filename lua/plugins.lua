local M = {}

local packer_bootstrap = false

local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap =
            fn.system {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
        vim.cmd [[packadd packer.nvim]]
    end
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
end

packer_init()

function M.setup()
    local conf = {
        compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
        display = {
            open_fn = function()
                return require("packer.util").float {border = "rounded"}
            end
        }
    }

    local function plugins(use)
        use {"lewis6991/impatient.nvim"}
        -- Packer can manage itself
        use "wbthomason/packer.nvim"
        -- modules
        use {"nvim-lua/plenary.nvim", module = "plenary"}
        use {"nvim-lua/popup.nvim", module = "popup"}
        use {
            "kyazdani42/nvim-web-devicons",
            module = "nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup {default = true}
            end
        }
        -- highlighting
        use {
            "nvim-treesitter/nvim-treesitter",
            as = "nvim-treesitter",
            event = "BufRead",
            run = ":TSUpdate",
            opt = true,
            requires = {
                "p00f/nvim-ts-rainbow",
                "JoosepAlviste/nvim-ts-context-commentstring",
                {
                    "windwp/nvim-ts-autotag",
                    config = function()
                        require("nvim-ts-autotag").setup {enable = true}
                    end
                },
                {
                    "windwp/nvim-autopairs",
                    run = "make",
                    config = function()
                        require("nvim-autopairs").setup {}
                    end
                }
            },
            config = function()
                require("config.treesitter").setup()
            end
        }
        -- lsp stuff
        use {"williamboman/nvim-lsp-installer"}
        use {
            "neovim/nvim-lspconfig",
            as = "nvim-lspconfig",
            after = "nvim-treesitter",
            opt = true,
            requires = {
                "ray-x/lsp_signature.nvim"
            },
            config = function()
                require("config.lsp").setup(require("nvim-lsp-installer"))
            end
        }
        use {
            "folke/trouble.nvim",
            after = "nvim-lspconfig",
            event = "VimEnter",
            config = function()
                require("config.troubles").setup()
            end
        }
        use {
            "phpactor/phpactor",
            after = "nvim-lspconfig",
            event = "BufWinEnter",
            ft = "php",
            run = "composer install",
            config = function()
                require("utils").map_key(
                    "n",
                    "<leader>lp",
                    "<cmd>PhpactorContextMenu<CR>",
                    {silent = true, noremap = true}
                )
            end
        }

        use {
            "akinsho/flutter-tools.nvim",
            event = "VimEnter",
            ft = {"dart"},
            after = "nvim-lspconfig",
            config = function()
                require("flutter-tools").setup {
                    widget_guides = {
                        enabled = false
                    },
                    experimental = {
                        -- map of feature flags
                        lsp_derive_paths = true -- EXPERIMENTAL: Attempt to find the user's flutter SDK
                    },
                    outline = {
                        open_cmd = "30vnew" -- command to use to open the outline buffer
                    },
                    lsp = {
                        on_attach = require("config.lsp").on_attach
                    }
                }
            end
        }

        use {
            "hrsh7th/nvim-cmp",
            after = "nvim-treesitter",
            opt = true,
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "ray-x/cmp-treesitter",
                "hrsh7th/cmp-cmdline"
            },
            config = function()
                require("config.cmp-completion").setup()
            end
        }
        use {
            "tami5/lspsaga.nvim",
            after = "nvim-lspconfig",
            config = function()
                require("config.lsp-saga").setup()
            end
        }

        use "onsails/lspkind-nvim"
        use {
            "sbdchd/neoformat",
            event = "BufWinEnter",
            config = function()
                require("config.autoformats").setup()
            end
        }
        -- snippet support
        use {
            "hrsh7th/cmp-vsnip",
            after = "nvim-cmp",
            requires = {
                "hrsh7th/vim-vsnip",
                {
                    "hrsh7th/vim-vsnip-integ",
                    after = "vim-vsnip"
                },
                {
                    "rafamadriz/friendly-snippets",
                    after = "cmp-vsnip"
                }
            }
        }
        -- file managing , picker, theme, etc
        use {
            "kyazdani42/nvim-tree.lua",
            event = "BufWinEnter",
            config = function()
                require("config.tree").setup()
            end
        }
        use "nathom/filetype.nvim"
        use "norcalli/nvim-base16.lua"
        use {
            "hoob3rt/lualine.nvim",
            after = "nvim-treesitter",
            config = function()
                require("config.statusline").setup()
            end
        }
        use {
            "akinsho/nvim-bufferline.lua",
            after = "nvim-treesitter",
            event = "BufReadPre",
            config = function()
                require("config.top-bufferline").setup()
            end
        }
        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufWinEnter",
            config = function()
                require("colorizer").setup()
            end
        }
        use {
            "nvim-telescope/telescope.nvim",
            event = "VimEnter",
            requires = {
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-media-files.nvim"}
            },
            config = function()
                require("config.telescopes").setup()
            end
        }
        use {
            "lukas-reineke/indent-blankline.nvim",
            branch = "master",
            config = function()
                require("config.blankline").setup()
            end
        }
        -- git
        use {
            "lewis6991/gitsigns.nvim",
            requires = {"apzelos/blamer.nvim"},
            config = function()
                require("config.gitsign").setup()
            end
        }
        -- other
        use {
            "907th/vim-auto-save",
            event = "VimEnter",
            config = function()
                vim.g.auto_save = 1
                vim.g.auto_save_events = {"InsertLeave"}
                -- g.auto_save_events = ['InsertLeave', 'TextChanged']
                vim.g.auto_save_write_all_buffers = 1
            end
        }

        use {
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
            end
        }
        use {"chaoren/vim-wordmotion", event = "BufWinEnter"}
        use {
            "vim-test/vim-test",
            event = "BufWinEnter",
            config = function()
                require("config.test").setup()
            end
        }
        use "tpope/vim-sleuth"
        use {
            "editorconfig/editorconfig-vim",
            config = function()
                vim.g.EditorConfig_exec_path = "editorconfig"
                vim.g.EditorConfig_core_mode = "external_command"
            end
        }
        use {"alvan/vim-closetag", event = "BufWinEnter", ft = {"html", "php", "vue", "jsx", "xhtml", "htm", "jsx"}}
        use {
            "karb94/neoscroll.nvim",
            event = "BufWinEnter",
            config = function()
                require("neoscroll").setup() -- smooth scroll
            end
        }
        use {
            "folke/which-key.nvim",
            config = function()
                require("config.whichkey").setup()
            end
        }
        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}
        use {"schickling/vim-bufonly", event = "VimEnter"}
        use {"tpope/vim-surround", event = "BufWinEnter"}
        use {"mechatroner/rainbow_csv", event = "BufWinEnter", ft = "csv"}
        -- doc generate
        use {
            "kkoomen/vim-doge",
            run = ":call doge#install()",
            event = "VimEnter"
        }
        -- comment
        use {
            "folke/todo-comments.nvim",
            config = function()
                require("todo-comments").setup()
            end
        }
        use {
            "numToStr/Comment.nvim",
            keys = {"gc", "gb", "gcc", "gbc"},
            config = function()
                require("Comment").setup {
                    mappings = {extra = true}
                }
            end
        }
        -- workspace & dashboard
        use {
            "rmagatti/session-lens",
            requires = {"rmagatti/auto-session"},
            config = function()
                require("config.sessions").setup()
            end
        }
        -- search & replace
        use {
            "windwp/nvim-spectre",
            event = "VimEnter",
            config = function()
                require("config.spectres").setup()
            end
        }
        -- html
        use {
            "mattn/emmet-vim",
            ft = {"html", "css", "php", "vue"},
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
            end
        }

        if packer_bootstrap then
            print "Setting up Neovim. Restart required after installation!"
            require("packer").sync()
        end
    end

    pcall(require, "impatient")
    pcall(require, "packer_compiled")
    require("packer").init(conf)
    require("packer").startup(plugins)
end

return M

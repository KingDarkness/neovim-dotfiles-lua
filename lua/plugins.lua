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
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
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
        -- highlighting
        use "nvim-treesitter/nvim-treesitter"
        use {"folke/trouble.nvim"}
        use "p00f/nvim-ts-rainbow"
        -- lsp stuff
        use "neovim/nvim-lspconfig"
        use "williamboman/nvim-lsp-installer"
        -- use "hrsh7th/nvim-compe"

        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-nvim-lsp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-path"
        use "ray-x/cmp-treesitter"
        use "hrsh7th/cmp-cmdline"

        use "onsails/lspkind-nvim"
        use "sbdchd/neoformat"
        use "nvim-lua/plenary.nvim"
        use "ray-x/lsp_signature.nvim"
        use {"tami5/lspsaga.nvim"}
        use "akinsho/flutter-tools.nvim"
        use {"phpactor/phpactor", run = "composer install"}
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
        use "kyazdani42/nvim-tree.lua"
        use "nathom/filetype.nvim"

        use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        use "norcalli/nvim-base16.lua"
        use "hoob3rt/lualine.nvim"
        use "akinsho/nvim-bufferline.lua"
        use "norcalli/nvim-colorizer.lua"
        use {
            "nvim-telescope/telescope.nvim",
            requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}}
        }
        use "nvim-telescope/telescope-media-files.nvim"
        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}
        use {"lukas-reineke/indent-blankline.nvim", branch = "master"}
        -- git
        use "lewis6991/gitsigns.nvim"
        use "apzelos/blamer.nvim"
        -- other
        use "907th/vim-auto-save"
        use "junegunn/vim-easy-align"
        use "chaoren/vim-wordmotion"
        use "vim-test/vim-test"
        use "tpope/vim-sleuth"
        use "editorconfig/editorconfig-vim"
        use {
            "windwp/nvim-autopairs",
            run = "make",
            config = function()
                require("nvim-autopairs").setup {}
            end
        }
        use {
            "windwp/nvim-ts-autotag",
            config = function()
                require("nvim-ts-autotag").setup {enable = true}
            end
        }
        use "alvan/vim-closetag"
        use "karb94/neoscroll.nvim"
        use "folke/which-key.nvim"
        use "tweekmonster/startuptime.vim"
        use "schickling/vim-bufonly"
        use "tpope/vim-surround"
        use "mechatroner/rainbow_csv"
        -- doc generate
        use {
            "kkoomen/vim-doge",
            run = ":call doge#install()"
        }
        -- comment
        use "JoosepAlviste/nvim-ts-context-commentstring"
        use "folke/todo-comments.nvim"
        use "numToStr/Comment.nvim"
        -- workspace & dashboard
        use "rmagatti/auto-session"
        use "rmagatti/session-lens"
        -- search & replace
        use "mhinz/vim-grepper"
        use {
            "windwp/nvim-spectre",
            config = function()
                require("spectre-config").setup()
            end
        }
        -- html
        use "mattn/emmet-vim"

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

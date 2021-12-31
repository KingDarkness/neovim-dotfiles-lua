local packer = require("packer")
local use = packer.use

return require("packer").startup(
    function()
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
                },
                "hrsh7th/cmp-nvim-lsp-document-symbol"
            }
        }
        -- file managing , picker, theme, etc
        use "kyazdani42/nvim-tree.lua"

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
        use "kdav5758/TrueZen.nvim"
        use "folke/which-key.nvim"
        use "tweekmonster/startuptime.vim"
        use "schickling/vim-bufonly"
        use "tpope/vim-surround"
        use "mechatroner/rainbow_csv"
        -- doc generate
        use {
            "kkoomen/vim-doge",
            run = ":call doge#install()",
            config = function()
                require("config.doge").setup()
            end,
            event = "VimEnter"
        }
        -- comment
        use "JoosepAlviste/nvim-ts-context-commentstring"
        use "b3nj5m1n/kommentary"
        use "folke/todo-comments.nvim"
        -- workspace & dashboard
        use "rmagatti/auto-session"
        use "rmagatti/session-lens"
        -- search & replace
        use "mhinz/vim-grepper"
        -- html
        use "mattn/emmet-vim"
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)

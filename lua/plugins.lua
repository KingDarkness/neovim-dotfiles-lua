local packer = require("packer")
local use = packer.use

-- "

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- highlighting
  use "nvim-treesitter/nvim-treesitter"
  -- lsp stuff
  use "neovim/nvim-lspconfig"
  use 'kabouzeid/nvim-lspinstall'
  use "hrsh7th/nvim-compe"
  use "onsails/lspkind-nvim"
  use "sbdchd/neoformat"
  use "nvim-lua/plenary.nvim"
  -- snippet support
  use "hrsh7th/vim-vsnip"
  use "rafamadriz/friendly-snippets"

  -- file managing , picker, theme, etc
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "ryanoasis/vim-devicons"
  use "norcalli/nvim-base16.lua"
  use "glepnir/galaxyline.nvim"
  use "akinsho/nvim-bufferline.lua"
  use "norcalli/nvim-colorizer.lua"
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use "nvim-telescope/telescope-media-files.nvim"
  use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
  -- git
  use "lewis6991/gitsigns.nvim"
  use "apzelos/blamer.nvim"
  -- other
  use "907th/vim-auto-save"
  use "junegunn/vim-easy-align"
  use "vim-test/vim-test"
  use "editorconfig/editorconfig-vim"
  use "windwp/nvim-autopairs"
  use "alvan/vim-closetag"
  use "karb94/neoscroll.nvim"
  use "kdav5758/TrueZen.nvim"
  use "folke/which-key.nvim"
  use "tweekmonster/startuptime.vim"
  use "schickling/vim-bufonly"
  -- doc generate
  use { 'kkoomen/vim-doge', run = function() vim.fn['doge#install'](0) end }
  -- comment
  use "tpope/vim-commentary"
  -- workspace
  -- search & replace
  use "mhinz/vim-grepper"

end, {
  display = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
  }
})

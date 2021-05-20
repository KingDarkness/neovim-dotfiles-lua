local packer = require("packer")
local use = packer.use

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- highlighting
  use "nvim-treesitter/nvim-treesitter"
  use 'kyazdani42/nvim-web-devicons'
  -- file managing , picker, theme, etc
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "ryanoasis/vim-devicons"
  use {'sainnhe/gruvbox-material', as="gruvbox-material"}
  use "glepnir/galaxyline.nvim"
  use "akinsho/nvim-bufferline.lua"
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use "nvim-telescope/telescope-media-files.nvim"
  use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
  -- git
  use "lewis6991/gitsigns.nvim"
  -- other
  use "907th/vim-auto-save"
  use "junegunn/vim-easy-align"
  use "vim-test/vim-test"
  use "editorconfig/editorconfig-vim"
  -- doc generate
  use { 'kkoomen/vim-doge', run = function() vim.fn['doge#install'](0) end }

end, {
  display = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
  }
})

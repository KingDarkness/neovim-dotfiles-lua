local g = vim.g -- a table to access global variables
require "plugins"
g.mapleader = ","
-- global settings
require "settings"
require "key-maps"
require "autosave"
require "editorconfig"

-- themes
require "file-icons"
require "statusline"
require "tree"
require "top-bufferline"
require "custom-highlights"
require "blankline"
require("colorizer").setup()
require("neoscroll").setup() -- smooth scroll
-- file manager
require "telescopes"
-- workspace
require "sessions"
-- syntax highlight
require "treesitter"
-- lsp
require "compe-completion"
require "lspconfigs"
require("nvim-autopairs").setup()
-- git
require "gitsigns-settings"
-- setup for TrueZen.nvim
require "zenmode"
-- test runer
require "test"
-- comment
require "comment"
-- search & replace
require "grepper"
-- format code
require "autoformats"
-- emmet
require "emmet"

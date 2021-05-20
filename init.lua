local g = vim.g      -- a table to access global variables
require "plugins"
g.mapleader = ","
-- global settings
require "settings"
require "key-maps"
require "autosave"

-- themes
require "file-icons"
require "statusline"
require "tree"
require "top-bufferline"
require "custom-highlights"
require "blankline"
-- file manager
require "telescopes"
-- syntax highlight
require "treesitter"
-- git
require "gitsigns-settings"



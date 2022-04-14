-- enable log
-- _G.__is_log = true

require("plugins").setup()

vim.g.mapleader = ","

-- themes
local base16 = require "base16"
base16(base16.themes["onedark"], true)

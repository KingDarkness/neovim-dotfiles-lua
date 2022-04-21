local cmd = vim.cmd
local base16 = require "base16"
local colors = base16.themes["gruvbox-dark-medium"]

-- cmd "hi IndentBlanklineChar guifg=#383c44"

-- print(string.format("hi LineNr guifg=#%s", colors.base08))
-- misc --
cmd(string.format("hi LineNr guifg=#%s", colors.base08))
cmd(string.format("hi NvimInternalError guifg=#%s", colors.base08))
cmd(string.format("hi VertSplit guifg=#%s", colors.base03))
cmd(string.format("hi EndOfBuffer guifg=%s", colors.base03))
cmd "highlight default link HighlightedyankRegion IncSearch"
-- inactive statuslines as thin splitlines
cmd(string.format("highlight! StatusLineNC gui=underline guifg=#%s", colors.base03))

-- line n.o
cmd "hi clear CursorLine"
cmd(string.format("hi cursorlinenr guifg=#%s", colors.base0B))

-- git signs ---
cmd(string.format("hi DiffAdd guifg=#%s guibg = none", colors.base0D))
cmd(string.format("hi DiffChange guifg =#%s guibg = none", colors.base0C))
cmd(string.format("hi DiffModified guifg = #%s guibg = none", colors.base09))
--
-- telescope
cmd(string.format("hi TelescopeBorder   guifg=#%s", colors.base04))
cmd(string.format("hi TelescopePromptBorder   guifg=#%s", colors.base04))
cmd(string.format("hi TelescopeResultsBorder  guifg=#%s", colors.base04))
cmd(string.format("hi TelescopePreviewBorder  guifg=#%s", colors.base04))

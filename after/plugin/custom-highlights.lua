local cmd = vim.cmd
-- blankline

cmd "hi IndentBlanklineChar guifg=#383c44"

-- misc --
cmd "hi LineNr guifg=#be5046"
cmd "hi NvimInternalError guifg=#f9929b"
cmd "hi VertSplit guifg=#2a2e36"
cmd "hi EndOfBuffer guifg=#1e222a"
-- inactive statuslines as thin splitlines
cmd("highlight! StatusLineNC gui=underline guifg=#383c44")

-- line n.o
cmd "hi clear CursorLine"
cmd "hi cursorlinenr guifg=#A3BE8C"

-- git signs ---
cmd "hi DiffAdd guifg=#81A1C1 guibg = none"
cmd "hi DiffChange guifg =#3A3E44 guibg = none"
cmd "hi DiffModified guifg = #81A1C1 guibg = none"

-- NvimTree
cmd "hi NvimTreeFolderIcon guifg = #61afef"
cmd "hi NvimTreeFolderName guifg = #61afef"
cmd "hi NvimTreeIndentMarker guifg=#383c44"
cmd "hi NvimTreeNormal guibg=#1b1f27"
cmd "hi NvimTreeVertSplit guifg=#1e222a"
cmd "hi NvimTreeRootFolder guifg=#f9929b"

-- telescope
cmd "hi TelescopeBorder   guifg=#525865"
cmd "hi TelescopePromptBorder   guifg=#525865"
cmd "hi TelescopeResultsBorder  guifg=#525865"
cmd "hi TelescopePreviewBorder  guifg=#525865"

-- error / warnings
cmd "hi LspDiagnosticsSignError guifg=#f9929b"
cmd "hi LspDiagnosticsVirtualTextError guifg=#BF616A"
cmd "hi LspDiagnosticsSignWarning guifg=#EBCB8B"
cmd "hi LspDiagnosticsVirtualTextWarning guifg=#EBCB8B"

-- info
cmd "hi LspDiagnosticsSignInformation guifg=#A3BE8C"
cmd "hi LspDiagnosticsVirtualTextInformation guifg=#A3BE8C"

-- hint
cmd "hi LspDiagnosticsSignHint guifg=#b6bdca"
cmd "hi LspDiagnosticsVirtualTextHint guifg=#b6bdca"

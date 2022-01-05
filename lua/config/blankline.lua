local M = {}
local g = vim.g -- a table to access global variables

function M.setup()
    g.indentLine_enabled = 1
    g.indent_blankline_char = "▏"

    g.indent_blankline_filetype_exclude = {"help", "terminal"}
    g.indent_blankline_buftype_exclude = {"terminal"}

    g.indent_blankline_show_trailing_blankline_indent = false
    g.indent_blankline_show_first_indent_level = false
end

return M

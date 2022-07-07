local M = {}
local g = vim.g -- a table to access global variables

function M.setup()
    require("gitsigns").setup {
        signs = {
            add = {hl = "DiffAdd", text = "▌", numhl = "GitSignsAddNr"},
            change = {hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr"},
            delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
            topdelete = {hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr"},
            changedelete = {hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr"}
        },
        numhl = false,
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        sign_priority = 5,
        status_formatter = nil -- Use default
    }

    g.blamer_enabled = 1
    g.blamer_show_in_visual_modes = 0
    g.blamer_show_in_insert_modes = 0
    g.blamer_delay = 500
end

return M

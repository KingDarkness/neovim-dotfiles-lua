local M = {}

function M.setup()
    -- saga
    require("lspsaga").setup({
        preview = {
            lines_above = 0,
            lines_below = 10,
        },
        scroll_preview = {
            scroll_down = "<C-f>",
            scroll_up = "<C-b>",
        },
        request_timeout = 2000,
    })
end
return M

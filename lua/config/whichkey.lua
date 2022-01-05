local M = {}

local mappings = {
    ["w"] = {"<Cmd>w!<Cr>", "Save"},
    ["q"] = {"<Cmd>q!<Cr>", "Quit"},
    ["z"] = {
        name = "System",
        t = {"<Cmd>Telescope colorscheme<Cr>", "Color scheme"},
        h = {"<Cmd>15sp +term<CR>", "New horizontal terminal"},
        r = {"<Cmd>luafile %<Cr>", "Reload lua file"},
        m = {"<Cmd>messages<Cr>", "Messages"},
        p = {"<Cmd>messages clear<Cr>", "Clear messages"},
        u = {"<Cmd>PackerUpdate<Cr>", "Packer update"},
        c = {"<Cmd>PackerCompile<Cr>", "Packer update"}
    },
    -- Buffer
    b = {
        name = "Buffer",
        -- a = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
        a = {"<Cmd>BOnly<Cr>", "Delete all buffers"},
        d = {"<Cmd>bd<Cr>", "Delete current buffer"},
        l = {"<Cmd>ls<Cr>", "List buffers"},
        n = {"<Cmd>bn<Cr>", "Next buffer"},
        p = {"<Cmd>bp<Cr>", "Previous buffer"},
        f = {"<Cmd>bd!<Cr>", "Force delete current buffer"}
    },
    -- number
    n = {
        name = "Line Number",
        r = {"<Cmd>set relativenumber<Cr>", "Set relativenumber"},
        n = {"<Cmd>set norelativenumber<Cr>", "Set norelativenumber"}
    }
}

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true
}

function M.setup()
    local wk = require "which-key"
    wk.setup {}
    wk.register(mappings, opts)
end

return M

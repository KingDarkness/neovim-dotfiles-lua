local M = {}

local mappings = {
    ["w"] = {"<Cmd>w!<Cr>", "Save"},
    ["q"] = {"<Cmd>q!<Cr>", "Quit"},
    ["v"] = {"<Cmd>vsplit<CR>", "V split"},
    ["h"] = {"<Cmd>split<CR>", "H split"},
    ["<space>"] = {"<Cmd>noh<CR>", "Clear search highlight"},
    ["f"] = {[[:/<C-r><C-w><CR>]], "Search current word in file"},
    ["R"] = {
        name = "Replace"
    },
    ["z"] = {
        name = "System",
        t = {"<Cmd>Telescope colorscheme<Cr>", "Color scheme"},
        r = {"<Cmd>luafile %<Cr>", "Reload lua file"},
        m = {"<Cmd>messages<Cr>", "Messages"},
        p = {"<Cmd>messages clear<Cr>", "Clear messages"},
        u = {"<Cmd>PackerUpdate<Cr>", "Packer update"},
        c = {"<Cmd>PackerCompile<Cr>", "Packer update"}
    },
    -- copy
    ["y"] = {
        name = "Copy",
        a = {"[[ <Cmd> %y+<CR>]]", "Copy All"}
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
        f = {"<Cmd>bd!<Cr>", "Force delete current buffer"},
        h = {"<Cmd>15sp +term<CR>", "New horizontal terminal"}
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

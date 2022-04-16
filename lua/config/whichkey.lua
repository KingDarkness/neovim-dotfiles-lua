local M = {}

local nmapings = {
    ["w"] = {"<Cmd>w<Cr>", "Save"},
    ["W"] = {"<Cmd>w!<Cr>", "Force save"},
    ["q"] = {"<Cmd>q<Cr>", "Quit"},
    ["Q"] = {"<Cmd>q!<Cr>", "Force quit"},
    ["v"] = {"<Cmd>vsplit<CR>", "V split"},
    ["h"] = {"<Cmd>split<CR>", "H split"},
    ["<space>"] = {"<Cmd>noh<CR>", "Clear search highlight"},
    ["f"] = {
        name = "Search",
        w = {[[:/<C-r><C-w><CR>]], "Current word in file"}
    },
    ["R"] = {
        name = "Replace",
        w = {[[:lua require("utils").normalReplace("all")<CR>]], "Current word in file"},
        l = {[[:lua require("utils").normalReplace("line")<CR>]], "Current word in line"},
        n = {
            [[:lua require("utils").normalReplace("here_next_lines")<CR>]],
            "Current word from pos to next ? lines"
        },
        e = {
            [[:lua require("utils").normalReplace("here_to_end")<CR>]],
            "Current word from pos to end of file"
        },
        c = {
            name = "With confirm",
            w = {[[:lua require("utils").normalReplace("all", "confirm")<CR>]], "Current word in file"},
            l = {[[:lua require("utils").normalReplace("line", "confirm")<CR>]], "Current word in line"},
            n = {
                [[:lua require("utils").normalReplace("here_next_lines", "confirm")<CR>]],
                "Current word from pos to next ? lines"
            },
            e = {
                [[:lua require("utils").normalReplace("here_to_end", "confirm")<CR>]],
                "Current word from pos to end of file"
            }
        }
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
        t = {"<Cmd>15sp +term<CR>", "New horizontal terminal"}
    },
    -- number
    n = {
        name = "Line Number",
        r = {"<Cmd>set relativenumber<Cr>", "Set relativenumber"},
        n = {"<Cmd>set norelativenumber<Cr>", "Set norelativenumber"}
    },
    l = {name = "Extra language action"},
    t = {name = "Test"},
    g = {
        name = "Git",
        d = {"<Cmd>DiffviewOpen<Cr>", "Diffview open"},
        c = {"<Cmd>DiffviewClose<Cr>", "Diffview close"},
        h = {"<Cmd>DiffviewFileHistory<Cr>", "File history"}
    }
}

local vmapings = {
    ["f"] = {
        name = "Search",
        w = {[[:lua require("utils").visualSearch()<CR>]], "Current selected in file"}
    },
    ["R"] = {
        name = "Replace",
        w = {[[:lua require("utils").visualReplace("all")<CR>]], "Current selected in file"},
        l = {[[:lua require("utils").visualReplace("line")<CR>]], "Current selected in line"},
        n = {
            [[:lua require("utils").visualReplace("here_next_lines")<CR>]],
            "Current selected from pos to next ? lines"
        },
        e = {
            [[:lua require("utils").visualReplace("here_to_end")<CR>]],
            "Current selected from pos to end of file"
        },
        c = {
            name = "With confirm",
            w = {[[:lua require("utils").visualReplace("all", "confirm")<CR>]], "Current selected in file"},
            l = {[[:lua require("utils").visualReplace("line", "confirm")<CR>]], "Current selected in line"},
            n = {
                [[:lua require("utils").visualReplace("here_next_lines", "confirm")<CR>]],
                "Current selected from pos to next ? lines"
            },
            e = {
                [[:lua require("utils").visualReplace("here_to_end", "confirm")<CR>]],
                "Current selected from pos to end of file"
            }
        }
    }
}

local nopts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true
}

local vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true
}

function M.setup()
    local wk = require "which-key"
    wk.setup {}
    wk.register(nmapings, nopts)
    wk.register(vmapings, vopts)
end

return M

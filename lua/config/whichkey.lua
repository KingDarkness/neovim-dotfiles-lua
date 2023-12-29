local M = {}

local nmapings = {
    ["w"] = {
        name = "Window",
        ["+"] = { "<Cmd>resize+5<CR>+", "+ height" },
        ["-"] = { "<Cmd>resize-5<CR>", "- height" },
        [">"] = { "<Cmd>vertical resize+5<CR>", "+ width" },
        ["<"] = { "<Cmd>vertical resize-5<CR>", "- width" },
        v = { "<Cmd>vsplit<CR>", "V split" },
        h = { "<Cmd>split<CR>", "H split" },
        q = { "<Cmd>bd<CR>", "Close window" },
        Q = { "<Cmd>Bonly<CR>", "Close other window" },
        F = { "<Cmd>resize 100<CR>+", "Full height" },
    },
    ["W"] = { "<Cmd>w!<Cr>", "Force save" },
    ["q"] = { "<Cmd>q<Cr>", "Quit" },
    ["Q"] = { "<Cmd>q!<Cr>", "Force quit" },
    ["p"] = { "<Cmd>TelescopeFile<CR>", "TelescopeFile" },
    ["r"] = { "<cmd>TelescopeTreesitter<CR>", "TelescopeTreesitter" },
    ["m"] = { "<cmd>TelescopeMediaFile<CR>", "TelescopeMediaFile" },
    ["<space>"] = { "<Cmd>noh<CR>", "Clear search highlight" },
    ["f"] = {
        name = "Search",
        w = { [[:/<C-r><C-w><CR>]], "Current word in file" },
    },
    ["R"] = {
        name = "Replace",
        w = { [[:lua require("utils").normalReplace("all")<CR>]], "Current word in file" },
        l = { [[:lua require("utils").normalReplace("line")<CR>]], "Current word in line" },
        n = {
            [[:lua require("utils").normalReplace("here_next_lines")<CR>]],
            "Current word from pos to next ? lines",
        },
        e = {
            [[:lua require("utils").normalReplace("here_to_end")<CR>]],
            "Current word from pos to end of file",
        },
        c = {
            name = "With confirm",
            w = { [[:lua require("utils").normalReplace("all", "confirm")<CR>]], "Current word in file" },
            l = { [[:lua require("utils").normalReplace("line", "confirm")<CR>]], "Current word in line" },
            n = {
                [[:lua require("utils").normalReplace("here_next_lines", "confirm")<CR>]],
                "Current word from pos to next ? lines",
            },
            e = {
                [[:lua require("utils").normalReplace("here_to_end", "confirm")<CR>]],
                "Current word from pos to end of file",
            },
        },
    },
    ["z"] = {
        name = "System",
        t = { "<Cmd>Telescope colorscheme<Cr>", "Color scheme" },
        o = { "<Cmd>Telescope vim_options<Cr>", "Options" },
        k = { "<Cmd>Telescope keymaps<Cr>", "Keymaps" },
        r = { "<Cmd>luafile %<Cr>", "Reload lua file" },
        m = { "<Cmd>messages<Cr>", "Messages" },
        p = { "<Cmd>messages clear<Cr>", "Clear messages" },
        u = { "<Cmd>PackerUpdate<Cr>", "Packer update" },
        c = { "<Cmd>PackerCompile<Cr>", "Packer update" },
    },
    -- copy
    ["y"] = {
        name = "Copy",
        a = { "[[ <Cmd> %y+<CR>]]", "Copy All" },
    },
    -- Buffer
    b = {
        name = "Buffer",
        -- a = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
        a = { "<Cmd>BOnly<Cr>", "Delete all buffers" },
        d = { "<Cmd>bd<Cr>", "Delete current buffer" },
        l = { "<Cmd>Telescope buffers<Cr>", "List buffers" },
        n = { "<Cmd>bn<Cr>", "Next buffer" },
        p = { "<Cmd>bp<Cr>", "Previous buffer" },
        f = { "<Cmd>bd!<Cr>", "Force delete current buffer" },
        t = { "<Cmd>15sp +term<CR>", "New horizontal terminal" },
    },
    -- number
    n = {
        name = "Line Number",
        r = { "<Cmd>set relativenumber<Cr>", "Set relativenumber" },
        n = { "<Cmd>set norelativenumber<Cr>", "Set norelativenumber" },
    },
    l = {
        name = "Extra language action",
        ["f"] = { "<cmd>FlutterTool<CR>", "FlutterTool" },
        ["t"] = { "<cmd>TodoTelescope<CR>", "TodoTelescope" },
    },
    t = { name = "Test" },
    g = {
        name = "Git",
        d = { "<Cmd>DiffviewOpen<Cr>", "Diffview open" },
        c = { "<Cmd>DiffviewClose<Cr>", "Diffview close" },
        h = { "<Cmd>DiffviewFileHistory<Cr>", "File history" },
        b = { "<Cmd>Telescope git_branches<Cr>", "Brachs" },
        m = { "<Cmd>Telescope git_bcommits<Cr>", "Commits" },
        s = { "<Cmd>Telescope git_status<Cr>", "Status" },
    },
    -- Jump
    j = {
        name = "Jump",
        a = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add" },
        m = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "Menu" },
        p = { "<Cmd>Telescope harpoon marks <CR>", "Telescope Menu" },
        n = { "<Cmd>lua require('harpoon.ui').nav_next() <Cr>", "Jump next" },
        l = { "<Cmd>lua require('harpoon.ui').nav_prev() <Cr>", "Jump previous" },
        t = { "<Cmd>lua require('harpoon.term').gotoTerminal(1)<Cr>", "Terminal" },
    },
}

local vmapings = {
    ["f"] = {
        name = "Search",
        w = { [[:lua require("utils").visualSearch()<CR>]], "Current selected in file" },
    },
    ["R"] = {
        name = "Replace",
        w = { [[:lua require("utils").visualReplace("all")<CR>]], "Current selected in file" },
        l = { [[:lua require("utils").visualReplace("line")<CR>]], "Current selected in line" },
        n = {
            [[:lua require("utils").visualReplace("here_next_lines")<CR>]],
            "Current selected from pos to next ? lines",
        },
        e = {
            [[:lua require("utils").visualReplace("here_to_end")<CR>]],
            "Current selected from pos to end of file",
        },
        c = {
            name = "With confirm",
            w = { [[:lua require("utils").visualReplace("all", "confirm")<CR>]], "Current selected in file" },
            l = { [[:lua require("utils").visualReplace("line", "confirm")<CR>]], "Current selected in line" },
            n = {
                [[:lua require("utils").visualReplace("here_next_lines", "confirm")<CR>]],
                "Current selected from pos to next ? lines",
            },
            e = {
                [[:lua require("utils").visualReplace("here_to_end", "confirm")<CR>]],
                "Current selected from pos to end of file",
            },
        },
    },
}

local nopts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

function M.setup()
    local wk = require("which-key")
    wk.setup({})
    wk.register(nmapings, nopts)
    wk.register(vmapings, vopts)
end

return M

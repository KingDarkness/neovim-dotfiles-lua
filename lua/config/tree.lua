local M = {}
local g = vim.g
local utils = require("utils")
vim.o.termguicolors = true

function M.setup()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local tree_cb = require "nvim-tree.config".nvim_tree_callback
    local keymaps = {
        {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
        {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
        {key = "<C-v>", cb = tree_cb("vsplit")},
        {key = "<C-x>", cb = tree_cb("split")},
        {key = "<C-t>", cb = tree_cb("tabnew")},
        {key = "<", cb = tree_cb("prev_sibling")},
        {key = ">", cb = tree_cb("next_sibling")},
        {key = "P", cb = tree_cb("parent_node")},
        {key = "<BS>", cb = tree_cb("close_node")},
        {key = "<S-CR>", cb = tree_cb("close_node")},
        {key = "<Tab>", cb = tree_cb("preview")},
        {key = "K", cb = tree_cb("first_sibling")},
        {key = "J", cb = tree_cb("last_sibling")},
        {key = "I", cb = tree_cb("toggle_ignored")},
        {key = "H", cb = tree_cb("toggle_dotfiles")},
        {key = "R", cb = tree_cb("refresh")},
        {key = "a", cb = tree_cb("create")},
        {key = "d", cb = tree_cb("remove")},
        {key = "r", cb = tree_cb("rename")},
        {key = "<C-r>", cb = tree_cb("full_rename")},
        {key = "x", cb = tree_cb("cut")},
        {key = "c", cb = tree_cb("copy")},
        {key = "p", cb = tree_cb("paste")},
        {key = "y", cb = tree_cb("copy_name")},
        {key = "Y", cb = tree_cb("copy_path")},
        {key = "gy", cb = tree_cb("copy_absolute_path")},
        {key = "[c", cb = tree_cb("prev_git_item")},
        {key = "]c", cb = tree_cb("next_git_item")},
        {key = "-", cb = tree_cb("dir_up")},
        {key = "q", cb = tree_cb("close")},
        {key = "?", cb = tree_cb("toggle_help")}
    }

    -- following options are the default
    require "nvim-tree".setup {
        -- disables netrw completely
        disable_netrw = true,
        -- will not open on setup if the filetype is in this list
        ignore_ft_on_setup = {".git", "node_modules", ".cache"},
        -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
        update_focused_file = {
            -- enables the feature
            enable = true
        },
        git = {
            enable = true,
            ignore = false,
            show_on_dirs = true,
            timeout = 400
        },
        view = {
            -- width of the window, can be either a number (columns) or a string in `%`
            width = 30,
            -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
            side = "left",
            adaptive_size = true,
            mappings = {
                -- custom only false will merge the list with the default mappings
                -- if true, it will only use your list to set the mappings
                custom_only = false,
                -- list of mappings to set on the tree manually
                list = keymaps
            }
        },
        actions = {
            open_file = {
                quit_on_open = true,
                resize_window = true,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = {"notify", "packer", "qf", "diff", "fugitive", "fugitiveblame"},
                        buftype = {"nofile", "terminal", "help"}
                    }
                }
            }
        }
    }

    -- Mappings for nvimtree
    utils.map_key(
        "n",
        "<F3>",
        ":NvimTreeToggle<CR>",
        {
            noremap = true,
            silent = true
        }
    )

    utils.map_key(
        "n",
        "tt",
        ":NvimTreeToggle<CR>",
        {
            noremap = true,
            silent = true
        }
    )

    vim.api.nvim_exec(
        [[
    augroup NvimTreeOptions
        autocmd BufEnter NvimTree set cursorline
    augroup END
]],
        false
    )
end

return M

local M = {}
local utils = require("utils")
function M.setup()
    require("telescope").setup {
        defaults = {
            layout_config = {
                prompt_position = "bottom"
            },
            prompt_prefix = " ",
            selection_caret = " ",
            entry_prefix = "  ",
            file_sorter = require "telescope.sorters".get_fuzzy_file,
            file_ignore_patterns = {".git"},
            generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
            path_display = {},
            set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
            file_previewer = require "telescope.previewers".vim_buffer_cat.new,
            grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
            qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
        },
        extensions = {
            media_files = {
                filetypes = {"png", "webp", "jpg", "jpeg"},
                find_cmd = "rg" -- find command (defaults to `fd`)
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    winblend = 15,
                    layout_config = {
                        prompt_position = "top",
                        width = 64,
                        height = 15
                    },
                    border = {},
                    previewer = false,
                    shorten_path = false
                }
            }
        },
        pickers = {
            find_files = {
                theme = "ivy"
            },
            treesitter = {
                theme = "ivy"
            },
            buffers = {
                theme = "ivy"
            }
        }
    }

    require("telescope").load_extension("media_files")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("flutter")
    require("telescope").load_extension("ui-select")

    local opt = {noremap = true, silent = true}

    utils.setup_commands(
        {
            {name = "TelescopeFile", cmd = "find_files({hidden = true})"},
            {name = "TelescopeTreesitter", cmd = "treesitter()"}
        },
        "telescope.builtin"
    )
    utils.setup_commands(
        {
            {name = "TelescopeMediaFile", cmd = "extensions.media_files.media_files()"},
            {name = "FlutterTool", cmd = "extensions.flutter.commands()"}
        },
        "telescope"
    )

    -- mappings
    utils.map_key("n", "<Leader>p", [[<Cmd>TelescopeFile<CR>]], opt)
    utils.map_key("n", "<Leader>r", [[<Cmd>TelescopeTreesitter<CR>]], opt)
    utils.map_key("n", "<Leader>m", [[<Cmd>TelescopeMediaFile<CR>]], opt)
    utils.map_key("n", "<Leader>lf", [[<Cmd>FlutterTool<CR>]], opt)
    utils.map_key("n", "<leader>lt", "<cmd>TodoTelescope<cr>", opt)
end

return M

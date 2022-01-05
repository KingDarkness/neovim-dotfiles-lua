local M = {}
function M.setup()
    require("telescope").setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--ignore",
                "--hidden",
                "--files"
            },
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

    local opt = {noremap = true, silent = true}

    -- mappings
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>p",
        [[<Cmd>lua require('telescope.builtin').find_files({find_command={'rg','--ignore','--hidden','--files'}})<CR>]],
        opt
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>r",
        [[<Cmd>lua require('telescope.builtin').treesitter({default_text = ':method:'})<CR>]],
        opt
    )
    vim.api.nvim_set_keymap(
        "n",
        "<Leader>fp",
        [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]],
        opt
    )

    vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
    vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope').extensions.flutter.commands()<CR>]], opt)
end

return M
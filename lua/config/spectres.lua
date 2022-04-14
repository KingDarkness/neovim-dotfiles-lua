local M = {}
local utils = require("utils")
local replace_tool = utils.isMacOs() and "gsed" or "sed"
local state = require("spectre.state")

function M.setup()
    require("spectre").setup(
        {
            color_devicons = true,
            open_cmd = "vnew",
            live_update = true, -- auto excute search again when you write any file in vim
            line_sep_start = "┌-----------------------------------------",
            result_padding = "¦  ",
            line_sep = "└-----------------------------------------",
            highlight = {
                ui = "Constant",
                filename = "Keyword",
                filedirectory = "Comment",
                search = "String",
                border = "Comment",
                replace = "DiffDelete"
            },
            find_engine = {
                -- rg is map with finder_cmd
                ["rg"] = {
                    cmd = "rg",
                    -- default args
                    args = {
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column"
                    },
                    options = {
                        ["ignore-case"] = {
                            value = "--ignore-case",
                            icon = "[I]",
                            desc = "ignore case"
                        },
                        ["hidden"] = {
                            value = "--hidden",
                            desc = "hidden file",
                            icon = "[H]"
                        }
                        -- you can put any rg search option you want here it can toggle with
                        -- show_option function
                    }
                },
                ["ag"] = {
                    cmd = "ag",
                    -- default args
                    args = {
                        "--vimgrep",
                        "-s"
                    },
                    options = {
                        ["ignore-case"] = {
                            value = "-i",
                            icon = "[I]",
                            desc = "ignore case"
                        },
                        ["hidden"] = {
                            value = "--hidden",
                            desc = "hidden file",
                            icon = "[H]"
                        }
                    }
                }
            },
            replace_engine = {
                ["sed"] = {
                    cmd = replace_tool,
                    args = nil
                },
                options = {
                    ["ignore-case"] = {
                        value = "--ignore-case",
                        icon = "[I]",
                        desc = "ignore case"
                    }
                }
            },
            default = {
                find = {
                    --pick one of item in find_engine
                    cmd = "ag",
                    options = {"hidden"}
                },
                replace = {
                    --pick one of item in replace_engine
                    cmd = "sed"
                    -- options = {"ignore-case"}
                }
            },
            replace_vim_cmd = "cdo",
            is_open_target_win = true, --open file on opener window
            is_insert_mode = false -- start open panel on is_insert_mode
        }
    )

    utils.setup_commands(
        {
            {name = "SearchInProject", cmd = "open_visual()"},
            {name = "SeachCurrentWordInProject", cmd = "open_visual({select_word=true})"}
        },
        "spectre"
    )

    utils.setup_commands(
        {
            {name = "SearchInDirectory", cmd = "search_on_directory()"},
            {name = "SearchCurrentWordInDirectory", cmd = "search_on_directory({select_word = true})"},
            {name = "SearchCurrentWordInFile", cmd = "search_on_file({select_word = true})"}
        },
        "config.spectres"
    )

    utils.map_key("n", "<leader>F", "<CMD>SearchInProject<CR>", {})
    utils.map_key("n", "<leader>fF", "<CMD>SearchInProject<CR>", {})
    utils.map_key("n", "<leader>ff", "<CMD>SearchCurrentWordInFile<CR>", {})
    utils.map_key("v", "<leader>F", "<CMD>SearchInProject<CR>", {})
    utils.map_key("n", "<leader>fW", "<CMD>SeachCurrentWordInProject<CR>", {})
    utils.map_key("n", "<leader>fd", "<CMD>SearchCurrentWordInDirectory<CR>", {})
    utils.map_key("n", "<leader>fD", "<CMD>SearchInDirectory<CR>", {})
    utils.map_key("v", "<leader>fD", "<CMD>SearchInDirectory<CR>", {})
end

function M.search_on_directory(opts)
    opts = opts or {}
    opts.path = utils.get_absolute_forder_path()
    if opts.select_word then
        opts.search_text = vim.fn.expand("<cword>")
    else
        opts.search_text = require("spectre.utils").get_visual_selection()
    end

    require("spectre").open(opts)
end

function M.search_on_file(opts)
    opts = opts or {}
    opts.path = utils.get_absolute_path()
    if opts.select_word then
        opts.search_text = vim.fn.expand("<cword>")
    else
        opts.search_text = require("spectre.utils").get_visual_selection()
    end

    require("spectre").open(opts)
end

function M.lualine()
    local spectre = {
        filetypes = {"spectre_panel"},
        sections = {
            lualine_a = {
                {
                    function()
                        return "ಠ_ಠ"
                    end
                }
            },
            lualine_b = {
                {
                    function()
                        local cfg = require("spectre.state_utils").get_search_engine_config()
                        local search_message = ""
                        for key, value in pairs(state.options) do
                            if value == true and cfg.options[key] then
                                search_message = search_message .. cfg.options[key].icon
                            end
                        end
                        return search_message
                    end,
                    color = {fg = "#d19a66"}
                }
            },
            lualine_c = {
                {
                    function()
                        return state.status_line
                    end
                }
            },
            lualine_y = {
                {
                    function()
                        local opts = {
                            state.user_config.default.find.cmd,
                            state.user_config.live_update and [[]] or "",
                            state.user_config.default.replace.cmd
                        }
                        return table.concat(opts, " ")
                    end
                }
            },
            lualine_z = {
                {
                    function()
                        return "Spectre"
                    end
                }
            }
        }
    }

    return spectre
end

return M

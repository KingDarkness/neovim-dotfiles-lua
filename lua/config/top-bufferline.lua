local M = {}
local utils = require("utils")

-- base16 onedark
local colors = {
    base00 = "#282c34",
    base01 = "#353b45",
    base02 = "#3e4451",
    base03 = "#545862",
    base04 = "#565c64",
    base05 = "#abb2bf",
    base06 = "#b6bdca",
    base07 = "#c8ccd4",
    base08 = "#e06c75",
    base09 = "#d19a66",
    base0A = "#e5c07b",
    base0B = "#98c379",
    base0C = "#56b6c2",
    base0D = "#61afef",
    base0E = "#c678dd",
    base0F = "#be5046"
}

function M.setup()
    require "bufferline".setup {
        options = {
            offsets = {{filetype = "NvimTree", text = "Explorer"}},
            buffer_close_icon = "",
            modified_icon = "",
            close_icon = " ",
            show_close_icon = false,
            left_trunc_marker = "",
            right_trunc_marker = "",
            max_name_length = 14,
            max_prefix_length = 13,
            tab_size = 20,
            show_tab_indicators = true,
            enforce_regular_tabs = false,
            view = "multiwindow",
            show_buffer_close_icons = false,
            separator_style = "thin",
            sort_by = "id"
        },
        highlights = {
            fill = {
                fg = colors.base06,
                bg = colors.base01
            },
            group_separator = {
                fg = colors.base06,
                bg = colors.base01
            },
            background = {
                fg = colors.base0F,
                bg = colors.base01
            },
            separator = {
                fg = colors.base08,
                bg = colors.base01
            },
            separator_selected = {
                fg = colors.base0C,
                bg = colors.base00
            },
            group_label = {
                fg = colors.base06,
                bg = colors.base01
            },
            duplicate = {
                fg = colors.base0F,
                bg = colors.base01,
                italic = true
            },
            duplicate_selected = {
                fg = colors.base0C,
                italic = true,
                bg = colors.base00
            },
            indicator_selected = {
                fg = colors.base0C,
                bg = colors.base00
            },
            buffer_selected = {
                fg = colors.base0C,
                bg = colors.base00,
                bold = true,
                italic = true
            }
        }
    }

    utils.map_key("n", "<leader>bc", [[<Cmd> BufferLinePick <CR>]], {})
end

return M

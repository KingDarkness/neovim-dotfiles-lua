local M = {}

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
                guifg = colors.base06,
                guibg = colors.base01
            },
            group_separator = {
                guifg = colors.base06,
                guibg = colors.base01
            },
            background = {
                guifg = colors.base0F,
                guibg = colors.base01
            },
            separator = {
                guifg = colors.base08,
                guibg = colors.base01
            },
            separator_selected = {
                guifg = colors.base0C,
                guibg = colors.base00
            },
            group_label = {
                guifg = colors.base06,
                guibg = colors.base01
            },
            duplicate = {
                guifg = colors.base0F,
                gui = "italic",
                guibg = colors.base01
            },
            duplicate_selected = {
                guifg = colors.base0C,
                gui = "italic",
                guibg = colors.base00
            },
            indicator_selected = {
                guifg = colors.base0C,
                guibg = colors.base00
            },
            buffer_selected = {
                guifg = colors.base0C,
                guibg = colors.base00,
                gui = "bold,italic"
            }
        }
    }

    vim.api.nvim_set_keymap("n", "gb", [[<Cmd> BufferLinePick <CR>]], {})
end

return M

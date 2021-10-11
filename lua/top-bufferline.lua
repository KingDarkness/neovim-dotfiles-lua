-- define some colors

local colors = {
    base00 = "#2b303b",
    base01 = "#343d46",
    base02 = "#4f5b66",
    base03 = "#65737e",
    base04 = "#a7adba",
    base05 = "#c0c5ce",
    base06 = "#dfe1e8",
    base07 = "#eff1f5",
    base08 = "#bf616a",
    base09 = "#d08770",
    base0A = "#ebcb8b",
    base0B = "#a3be8c",
    base0C = "#96b5b4",
    base0D = "#8fa1b3",
    base0E = "#b48ead",
    base0F = "#ab7967"
}

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

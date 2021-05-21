-- define some colors

local bar_fg = "#565c64"
local activeBuffer_fg = "#c8ccd4"

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
        mappings = "true",
        sort_by = "directory",
        -- custom_areas = {
        --   right = function()
        --     local result = {}
        --     local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        --     local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        --     local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        --     local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

        --     if error ~= 0 then
        --     result[1] = {text = "  " .. error, guifg = "#EC5241"}
        --     end

        --     if warning ~= 0 then
        --     result[2] = {text = "  " .. warning, guifg = "#EFB839"}
        --     end

        --     if hint ~= 0 then
        --     result[3] = {text = "  " .. hint, guifg = "#A3BA5E"}
        --     end

        --     if info ~= 0 then
        --     result[4] = {text = "  " .. info, guifg = "#7EA9A7"}
        --   end
        --   return result
        -- end
      -- }
    }, 
    -- bar colors!!
    highlights = {
        fill = {
            guifg = bar_fg,
            guibg = "#252931"
        },
        background = {
            guifg = bar_fg,
            guibg = "#252931"
        },
        -- buffer
        buffer_selected = {
            guifg = activeBuffer_fg,
            guibg = "#1e222a",
            gui = "bold"
        },
        buffer_visible = {
            guifg = "#9298a0",
            guibg = "#252931"
        },
        -- tabs over right
        tab = {
            guifg = "#9298a0",
            guibg = "#30343c"
        },
        tab_selected = {
            guifg = "#30343c",
            guibg = "#9298a0"
        },
        tab_close = {
            guifg = "#f9929b",
            guibg = "#252931"
        },
        -- buffer separators
        separator = {
            guifg = "#252931",
            guibg = "#252931"
        },
        separator_selected = {
            guifg = "#1e222a",
            guibg = "#1e222a"
        },
        separator_visible = {
            guifg = "#252931",
            guibg = "#252931"
        },
        indicator_selected = {
            guifg = "#252931",
            guibg = "#252931"
        },
        -- modified files (but not saved)
        modified_selected = {
            guifg = "#A3BE8C",
            guibg = "#1e222a"
        },
        modified_visible = {
            guifg = "#BF616A",
            guibg = "#23272f"
        }
    }
}

vim.api.nvim_set_keymap("n", "gb", [[<Cmd> BufferLinePick <CR>]], {})


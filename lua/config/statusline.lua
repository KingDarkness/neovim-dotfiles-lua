local M = {}
local base16 = require "base16"
local colors = base16.themes["gruvbox-dark-medium"]

local ocean = {
    normal = {
        a = {bg = colors.base0D, fg = colors.base00, gui = "bold"},
        b = {bg = colors.base01, fg = colors.base0B},
        c = {bg = colors.base01, fg = colors.base0B}
    },
    insert = {
        a = {bg = colors.base0B, fg = colors.base00, gui = "bold"},
        b = {bg = colors.base01, fg = colors.base0B},
        c = {bg = colors.base01, fg = colors.base0B}
    },
    visual = {
        a = {bg = colors.base09, fg = colors.base00, gui = "bold"},
        b = {bg = colors.base01, fg = colors.base0B},
        c = {bg = colors.base01, fg = colors.base0B}
    },
    replace = {
        a = {bg = colors.base08, fg = colors.base00, gui = "bold"},
        b = {bg = colors.base01, fg = colors.base0B},
        c = {bg = colors.base01, fg = colors.base0B}
    },
    command = {
        a = {bg = colors.base0A, fg = colors.base00, gui = "bold"},
        b = {bg = colors.base01, fg = colors.base0B},
        c = {bg = colors.base01, fg = colors.base0B}
    },
    inactive = {
        a = {bg = colors.base0E, fg = colors.base00, gui = "bold"},
        b = {bg = colors.base01, fg = colors.base0B},
        c = {bg = colors.base01, fg = colors.base0B}
    }
}

local condition = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
    checkwidth = function()
        local squeeze_width = vim.fn.winwidth(0) / 2
        if squeeze_width > 40 then
            return true
        end
        return false
    end
}

local function vi_mode()
    local alias = {
        n = " 🅝 NORMAL ",
        i = " 🅘 INSERT ",
        c = " 🅒 COMMAND ",
        V = " 🅥 VISUAL ",
        [""] = " 🅥 VISUAL ",
        v = " 🅥 VISUAL ",
        R = " 🅡 REPLACE "
    }

    return "   " .. alias[vim.fn.mode()]
end

local function filesize()
    local function format_file_size(file)
        local size = vim.fn.getfsize(file)
        if size <= 0 then
            return ""
        end
        local sufixes = {"b", "k", "m", "g"}
        local i = 1
        while size > 1024 do
            size = size / 1024
            i = i + 1
        end
        return string.format("%.1f%s", size, sufixes[i])
    end

    local file = vim.fn.expand("%:p")
    if string.len(file) == 0 then
        return ""
    end

    return format_file_size(file)
end

local function lsp_info()
    local get_lsp_client = function(msg)
        msg = msg or "No LSP"
        local clients = vim.lsp.buf_get_clients()
        if next(clients) == nil then
            return msg
        end

        local client_names = ""
        for _, client in pairs(clients) do
            if string.len(client_names) < 1 then
                client_names = client_names .. client.name
            else
                client_names = client_names .. ", " .. client.name
            end
        end
        return string.len(client_names) > 0 and client_names or msg
    end

    local icon = "  "
    local active_lsp = get_lsp_client()

    if active_lsp == "No Active Lsp" then
        icon = ""
        active_lsp = ""
    end

    return icon .. active_lsp .. " "
end

local function get_nvim_lsp_diagnostic(diag_type)
    if next(vim.lsp.buf_get_clients(0)) == nil then
        return ""
    end

    return #vim.diagnostic.get(0, {severity = diag_type})
end

local function get_diagnostic_error()
    if not vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
        return get_nvim_lsp_diagnostic(vim.diagnostic.severity.ERROR)
    end
    return ""
end

function get_diagnostic_warn()
    if not vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
        return get_nvim_lsp_diagnostic(vim.diagnostic.severity.WARN)
    end
    return ""
end

local config = {
    options = {
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        theme = ocean
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {{vi_mode}},
        lualine_b = {
            {"filename", condition = condition.buffer_not_empty},
            {filesize, condition = condition.buffer_not_empty}
        },
        lualine_c = {
            {lsp_info},
            {
                get_diagnostic_error,
                icon = "  ",
                color = {fg = colors.base08}
            },
            {
                get_diagnostic_warn,
                icon = "  ",
                color = {fg = colors.base09}
            }
        },
        lualine_x = {
            {"branch", icon = "", condition = condition.check_git_workspace}
        },
        lualine_y = {
            {
                "diff",
                symbols = {added = " ", modified = "柳 ", removed = " "},
                color_added = colors.base0B,
                color_modified = colors.base09,
                color_removed = colors.base08,
                condition = condition.hide_in_width
            }
        },
        lualine_z = {
            {"encoding", condition = condition.buffer_not_empty},
            {"fileformat", condition = condition.buffer_not_empty},
            {
                function()
                    return " " .. vim.fn.shiftwidth()
                end,
                condition = condition.buffer_not_empty
            },
            {
                function()
                    local cursor = vim.api.nvim_win_get_cursor(0)
                    return cursor[1] .. ":" .. cursor[2] .. "/" .. vim.api.nvim_buf_line_count(0)
                end,
                condition = condition.buffer_not_empty,
                icon = ""
            },
            {"progress", condition = condition.buffer_not_empty, icon = ""}
        }
    },
    extensions = {
        "quickfix",
        {
            sections = {
                lualine_a = {{"filename", icon = "פּ"}},
                lualine_z = {{"branch", icon = "", condition = condition.check_git_workspace}}
            },
            filetypes = {"NvimTree"}
        },
        require("config.spectres").lualine({})
    }
}

function M.setup()
    require("lualine").setup(config)
end

return M

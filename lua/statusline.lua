local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")

gl.short_line_list = {"packer", "NvimTree", "Outline", "LspTrouble"} -- keeping this table { } as empty will show inactive statuslines

local function spacing(num)
    return function()
        return string.rep(" ", num)
    end
end

local colors = {
    bg = "#1E2334",
    line_bg = "#1e222a",
    fg = "#D8DEE9",
    green = "#9FCF6A",
    orange = "#FF9E64",
    red = "#F6778E",
    lightbg = "#282c34",
    nord = "#7BA2F6",
    greenYel = "#EBCB8B"
}

local mode_color = {
    n = colors.nord,
    i = colors.green,
    v = colors.orange,
    V = colors.green,
    c = colors.greenYel,
    no = colors.nord,
    s = colors.orange,
    S = colors.orange,
    [""] = colors.orange,
    ic = colors.red,
    R = colors.red,
    Rv = colors.red,
    cv = colors.nord,
    ce = colors.nord,
    r = colors.red,
    rm = colors.red,
    ["r?"] = colors.green,
    ["!"] = colors.red,
    t = colors.red
}

gls.left[1] = {
    leftRounded = {
        provider = function()
            vim.api.nvim_command("hi GalaxyleftRounded guifg=" .. mode_color[vim.fn.mode()])
            return ""
        end,
        highlight = {colors.nord, colors.bg}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            vim.api.nvim_command("hi GalaxystatusIcon guibg=" .. mode_color[vim.fn.mode()])
            local alias = {
                n = " 🅝 NORMAL ",
                i = " 🅘 INSERT ",
                c = " 🅒 COMMAND ",
                V = " 🅥 VISUAL ",
                [""] = " 🅥 VISUAL ",
                v = " 🅥 VISUAL ",
                R = " 🅡 REPLACE "
            }
            return alias[vim.fn.mode()]
        end,
        highlight = {colors.bg, colors.nord},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg}
    }
}

gls.left[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.lightbg}
    }
}

gls.left[4] = {
    FileName = {
        provider = {
            "FileName",
            "FileSize"
        },
        condition = condition.buffer_not_empty,
        highlight = {colors.fg, colors.lightbg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[5] = {
    GetLspClient = {
        provider = {
            spacing(2),
            function()
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
            end,
            spacing(1)
        },
        highlight = {colors.green, colors.bg},
        icon = ""
    }
}

gls.left[6] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.bg}
    }
}

gls.left[7] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.orange, colors.bg}
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function()
            return "   "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = {"GitBranch", spacing(1)},
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.green, colors.line_bg}
    }
}

gls.right[3] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.greenYel, colors.line_bg}
    }
}

gls.right[4] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.orange, colors.line_bg}
    }
}

gls.right[5] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.red, colors.line_bg}
    }
}

gls.right[6] = {
    FileEncode = {
        provider = {
            spacing(2),
            function()
                return ""
            end,
            "FileEncode",
            function()
                return "["
            end,
            "FileFormat",
            function()
                return "]"
            end,
            function()
                return "  " .. vim.fn.shiftwidth()
            end
        },
        highlight = {colors.bg, colors.red}
    }
}

gls.right[7] = {
    LineInfo = {
        provider = function()
            local cursor = vim.api.nvim_win_get_cursor(0)
            vim.api.nvim_command("hi GalaxyFileEncode guibg=" .. mode_color[vim.fn.mode()])
            vim.api.nvim_command("hi GalaxyLineInfo guibg=" .. mode_color[vim.fn.mode()])
            return "   " .. cursor[1] .. ":" .. cursor[2] .. "/" .. vim.api.nvim_buf_line_count(0) .. " "
        end,
        highlight = {colors.bg, colors.fg}
    }
}

gls.right[8] = {
    PerCentSeparator = {
        provider = function()
            vim.api.nvim_command("hi GalaxyPerCentSeparator guibg=" .. mode_color[vim.fn.mode()])
            vim.api.nvim_command("hi GalaxyPerCent guibg=" .. mode_color[vim.fn.mode()])
            return "   "
        end,
        highlight = {colors.bg, colors.red}
    }
}

gls.right[9] = {
    PerCent = {
        provider = "LinePercent",
        highlight = {colors.bg, colors.red}
    }
}

gls.right[10] = {
    rightRounded = {
        provider = function()
            vim.api.nvim_command("hi GalaxyrightRounded guifg=" .. mode_color[vim.fn.mode()])
            return ""
        end,
        highlight = {colors.red, colors.bg}
    }
}

-- -------------------------Short status line---------------------------------------
gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = {"NONE", colors.line_bg},
        highlight = {colors.blue, colors.line_bg, "bold"}
    }
}

gls.short_line_left[2] = {
    SFileIcon = {
        provider = "FileIcon",
        highlight = {colors.fg, colors.bg}
    }
}

gls.short_line_left[3] = {
    SFileName = {
        provider = "SFileName",
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.line_bg, "bold"}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = "BufferIcon",
        highlight = {colors.white, colors.line_bg}
    }
}

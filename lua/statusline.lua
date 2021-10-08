local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")

gl.short_line_list = {"packer", "NvimTree", "Outline", "LspTrouble"} -- keeping this table { } as empty will show inactive statuslines

local function spacing(num)
    return function()
        return string.rep(" ", num)
    end
end

-- base16 ocean
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

local mode_color = {
    n = colors.base0D,
    i = colors.base0B,
    v = colors.base09,
    V = colors.base0B,
    c = colors.base0BYel,
    no = colors.base0D,
    s = colors.base09,
    S = colors.base09,
    [""] = colors.base09,
    ic = colors.base08,
    R = colors.base08,
    Rv = colors.base08,
    cv = colors.base0D,
    ce = colors.base0D,
    r = colors.base08,
    rm = colors.base08,
    ["r?"] = colors.base0B,
    ["!"] = colors.base08,
    t = colors.base08
}

gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = " 🅝 NORMAL ",
                i = " 🅘 INSERT ",
                c = " 🅒 COMMAND ",
                V = " 🅥 VISUAL ",
                [""] = " 🅥 VISUAL ",
                v = " 🅥 VISUAL ",
                R = " 🅡 REPLACE "
            }

            vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_color[vim.fn.mode()])
            vim.api.nvim_command("hi GalaxyPerCent guibg=" .. mode_color[vim.fn.mode()])
            vim.api.nvim_command("hi GalaxyPerCentSeparator guibg=" .. mode_color[vim.fn.mode()])
            vim.api.nvim_command("hi GalaxyPerCent guibg=" .. mode_color[vim.fn.mode()])
            vim.api.nvim_command("hi GalaxyLineInfo guibg=" .. mode_color[vim.fn.mode()])
            vim.api.nvim_command("hi GalaxyFileEncode guibg=" .. mode_color[vim.fn.mode()])

            return "   " .. alias[vim.fn.mode()]
        end,
        highlight = {colors.base01, colors.base0D},
        separator = " ",
        separator_highlight = {colors.base02, colors.base02}
    }
}

gls.left[2] = {
    FileIcon = {
        provider = "FileIcon",
        condition = condition.buffer_not_empty,
        highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.base02}
    }
}

gls.left[3] = {
    FileName = {
        provider = {
            "FileName",
            "FileSize"
        },
        condition = condition.buffer_not_empty,
        highlight = {colors.base05, colors.base02}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

gls.left[4] = {
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
        highlight = {colors.base0B, colors.base01},
        icon = ""
    }
}

gls.left[5] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.base08, colors.base01}
    }
}

gls.left[6] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.base09, colors.base01}
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function()
            return "    "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.base0B, colors.base01}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = {"GitBranch", spacing(1)},
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.base0B, colors.base01}
    }
}

gls.right[3] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.base0BYel, colors.base01}
    }
}

gls.right[4] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.base09, colors.base01}
    }
}

gls.right[5] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = " ",
        highlight = {colors.base08, colors.base01}
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
        highlight = {colors.base01, colors.base08}
    }
}

gls.right[7] = {
    LineInfo = {
        provider = function()
            local cursor = vim.api.nvim_win_get_cursor(0)
            return "   " .. cursor[1] .. ":" .. cursor[2] .. "/" .. vim.api.nvim_buf_line_count(0)
        end,
        highlight = {colors.base01, colors.base05}
    }
}

gls.right[8] = {
    PerCentSeparator = {
        provider = function()
            return "   "
        end,
        highlight = {colors.base01, colors.base08}
    }
}

gls.right[9] = {
    PerCent = {
        provider = "LinePercent",
        highlight = {colors.base01, colors.base08}
    }
}

-- -------------------------Short status line---------------------------------------
gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = {"NONE", colors.base03},
        highlight = {colors.blue, colors.base03, "bold"}
    }
}

gls.short_line_left[2] = {
    SFileIcon = {
        provider = "FileIcon",
        highlight = {colors.base05, colors.base01}
    }
}

gls.short_line_left[3] = {
    SFileName = {
        provider = "SFileName",
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.base03, "bold"}
    }
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = "BufferIcon",
        highlight = {colors.white, colors.base03}
    }
}

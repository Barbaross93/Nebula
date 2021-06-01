local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

local colors = {
    bg = "#2e3440",
    fg = "#e5e9f0",
    green = "#A3BE8C",
    red = "#bf616a",
    lightbg = "#242831",
    blue = "#81a1c1",
    yellow = "#ebcb8b",
    cyan = "#8fbcbb",
    magenta = "#b48ead",
    grey = "#3b4252"
}

gls.left[1] = {
    icon_left = {
        provider = function()
            return ""
        end,
        highlight = {colors.blue, colors.bg}
    }
}

gls.left[2] = {
    statusIcon = {
        provider = function()
            return "  ﮂ "
        end,
        highlight = {colors.bg, colors.blue},
        separator = "  ",
        separator_highlight = {colors.blue, colors.lightbg}
    }
}

gls.left[3] = {
    viMode_icon = {
        provider = function()
            return ""
        end,
        highlight = {colors.fg, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.cyan, colors.lightbg}
    }
}

gls.left[4] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "Normal",
                i = "Insert",
                c = "Command",
                V = "Visual",
                [""] = "Visual",
                v = "Visual",
                R = "Replace"
            }
            local current_Mode = alias[vim.fn.mode()]

            if current_Mode == nil then
                return "  Terminal "
            else
                return " " .. current_Mode .. " "
            end
        end,
        highlight = {colors.fg, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.lightbg, colors.bg}
    }
}

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 30 then
        return true
    end
    return false
end

gls.left[5] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.fg, colors.bg}
    }
}

gls.left[6] = {
    DiffModified = {
        provider = "DiffModified",
        condition = checkwidth,
        icon = "   ",
        highlight = {colors.magenta, colors.bg}
    }
}

gls.left[7] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = checkwidth,
        icon = "  ",
        highlight = {colors.magenta, colors.bg}
    }
}

gls.left[8] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.magenta, colors.bg}
    }
}

gls.left[9] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.bg}
    }
}

gls.right[1] = {
    GitIcon = {
        provider = function()
            return " "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.magenta, colors.lightbg},
        separator = "",
        separator_highlight = {colors.lightbg, colors.bg}
    }
}

gls.right[2] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.magenta, colors.lightbg}
    }
}

gls.right[3] = {
    FileIcon = {
        provider = "FileIcon",
        condition = buffer_not_empty,
        highlight = {colors.bg, colors.cyan},
        separator = " ",
        separator_highlight = {colors.cyan, colors.lightbg}
    }
}

gls.right[4] = {
    FileName = {
        provider = {"FileName"},
        condition = buffer_not_empty,
        highlight = {colors.cyan, colors.lightbg},
        separator =  "",
        separator_highlight = {colors.lightbg, colors.bg}
    }
}

gls.right[5] = {
    time_icon = {
        provider = function()
            return " "
        end,
        separator = "",
        separator_highlight = {colors.green, colors.bg},
        highlight = {colors.lightbg, colors.green}
    }
}

gls.right[6] = {
    time = {
        provider = function()
            return "  " .. os.date("%H:%M") .. " "
        end,
        highlight = {colors.green, colors.lightbg}
    }
}

gls.right[7] = {
    icon_right = {
        provider = function()
            return " "
        end,
        highlight = {colors.lightbg, colors.bg}
    }
}

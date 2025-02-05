return function()
    local C = require("colors")
    local theme = {}

    theme.normal = {
        a = { bg = C.black, fg = C.gray },
        b = { bg = C.black, fg = C.gray },
        c = { bg = C.black, fg = C.gray }
    }

    theme.insert = {
        a = { bg = C.string, fg = C.black }
    }

    theme.visual = {
        a = {
            bg = C.visual, fg = C.gray
        }
    }

    theme.command = {
        a = {
            bg = C.gray, fg = C.black
        }
    }

    theme.terminal = {
        a = {
            bg = C.keywords_and_operators, fg = C.black
        }
    }
    return theme

end

local hl = vim.api.nvim_set_hl

local colors = {
	constant = "#E6B450",
	function_definitions = "#FFB454",
	keywords_and_operators = "#FF8F40",
	type_definitions = "#59C2FF",
	comment = "#626A73",
	string = "#C2D94C",

	black = "#0A0E14",
	gray = "#B3B1AD",
	lgray = "#B9B9B9",
	indent = "#181A1D",
	visual = "#1C2631",
}

local M = {}

M.hl_base = function()
	-- Common
	hl(0, "Normal", { fg = colors.gray, bg = colors.black })
	hl(0, "Comment", { fg = colors.comment, italic = true })

	hl(0, "String", { fg = colors.string })
	hl(0, "Character", { fg = colors.string })

	hl(0, "Constant", { fg = colors.constant })
	hl(0, "Special", {})

	hl(0, "Function", { fg = colors.function_definitions })

	hl(0, "Operator", { fg = colors.keywords_and_operators })
	hl(0, "Keyword", { fg = colors.keywords_and_operators })
	hl(0, "Exception", { fg = colors.keywords_and_operators })
	hl(0, "Conditional", { fg = colors.keywords_and_operators })
	hl(0, "Label", { fg = colors.keywords_and_operators })
	hl(0, "Repeat", { fg = colors.keywords_and_operators })
	hl(0, "Statement", { fg = colors.keywords_and_operators })
	hl(0, "Bracket", {})

	hl(0, "Type", { fg = colors.type_definitions })

	hl(0, "Visual", { bg = colors.visual })
	hl(0, "Indent", { fg = colors.indent })
end

M.hl_langs = function()
	-- Custom
	hl(0, "@interpolation", { fg = colors.gray })

	-- Treesitter Functions
	hl(0, "@function.call", {})
	hl(0, "@function.method.call", {})
	hl(0, "@function.macro", {})
	hl(0, "@constructor", {})

	-- Treesitter brackets
	hl(0, "@punctuation.bracket", { link = "Bracket" })
	hl(0, "@punctuation.delimiter", { link = "Bracket" })
	hl(0, "@punctuation.special", { link = "Bracket" })

	-- Treesitter variables
	hl(0, "@variable", {})
	hl(0, "@variable.parameter", {})
	hl(0, "@variable.builtin", {})
	hl(0, "@variable.member", {})

	-- Treesitter modules
	hl(0, "@module", {})
	hl(0, "@module.builtin", {})

	-- Treesitter const
	hl(0, "@constant", {})
	hl(0, "@constant.builtin", {})

	-- Treesitter class
	hl(0, "@type", {})
	hl(0, "@type.definition", {})

	-- Treesitter string
	hl(0, "@string.escape", { link = "String" })

	-- Lua specific
	hl(0, "@variable.lua", {})
	hl(0, "@property.lua", {})
	hl(0, "@constructor.lua", { link = "Bracket" })
	hl(0, "luaTable", { link = "Bracket" })
	hl(0, "luaParen", { link = "Bracket" })
	hl(0, "luaFunc", { link = "Function" })

	-- Python specific
	hl(0, "@attribute.python", {})
	hl(0, "@type.definition.python", { link = "Type" })
	hl(0, "@NonePy.python", { link = "Constant" })

	-- Rust specific
	hl(0, "@keyword.modifier.rust", {})
	hl(0, "@attribute.rust", {})

	-- Bash specific
	hl(0, "@variable.parameter.bash", { link = "String" })

	-- Dockerfile specific
	hl(0, "@property.dockerfile", {})

	-- Yaml specific
	hl(0, "@property.yaml", { link = "Keyword" })
	hl(0, "@property.dockerfile", {})
end

M.hl_plugins = function()
	-- Telescope
	hl(0, "TelescopeMultiSelection", { fg = colors.constant })
	hl(0, "TelescopeResultsMethod", { fg = colors.function_definitions })
	hl(0, "TelescopeResultsClass", { fg = colors.type_definitions })
end

local highlight = function()
	for _, v in pairs(M) do
		v()
	end
end

local colorscheme = function()
	vim.api.nvim_command("hi clear")
	vim.o.termguicolors = true
	vim.g.colors_name = "pustota"
	highlight()
end

local ibl_setup = function()
	vim.api.nvim_set_hl(0, "Indent", { fg = "#000000" })
end

return { colorscheme = colorscheme, ibl_setup = ibl_setup }

local hl = vim.api.nvim_set_hl

local colors = require("colors")

local M = {}

M.hl_base = function()
	-- Common
	hl(0, "Normal", { fg = colors.gray, bg = colors.black })
	hl(0, "Comment", { fg = colors.comment, italic = true })

	hl(0, "String", { fg = colors.string })
	hl(0, "Character", { fg = colors.string })

	hl(0, "Constant", { fg = colors.constant })
	hl(0, "Special", { fg = colors.gray })

	hl(0, "Function", { fg = colors.function_definitions })

	hl(0, "Operator", { fg = colors.keywords_and_operators })
	hl(0, "Keyword", { fg = colors.keywords_and_operators })
	hl(0, "Exception", { fg = colors.keywords_and_operators })
	hl(0, "Conditional", { fg = colors.keywords_and_operators })
	hl(0, "Label", { fg = colors.keywords_and_operators })
	hl(0, "Repeat", { fg = colors.keywords_and_operators })
	hl(0, "Statement", { fg = colors.keywords_and_operators })
	hl(0, "Bracket", { fg = colors.gray })
	hl(0, "PreProc", { fg = colors.gray })

	hl(0, "Type", { fg = colors.type_definitions })

	hl(0, "Visual", { bg = colors.visual })
	hl(0, "Indent", { fg = colors.indent })
end

M.hl_langs = function()
	-- Custom
	hl(0, "@interpolation", { fg = colors.gray })

	-- Treesitter Functions
	hl(0, "@function.call", { fg = colors.gray })
	hl(0, "@function.method.call", { fg = colors.gray })
	hl(0, "@function.macro", { fg = colors.gray })
	hl(0, "@constructor", {})

	-- Treesitter brackets
	hl(0, "@punctuation.bracket", { link = "Bracket" })
	hl(0, "@punctuation.delimiter", { link = "Bracket" })
	hl(0, "@punctuation.special", { link = "Bracket" })

	-- Treesitter variables
	hl(0, "@variable", { fg = colors.gray })
	hl(0, "@variable.parameter", { fg = colors.gray })
	hl(0, "@variable.builtin", { fg = colors.gray })
	hl(0, "@variable.member", { fg = colors.gray })

	-- Treesitter modules
	hl(0, "@module", { fg = colors.gray })
	hl(0, "@module.builtin", { fg = colors.gray })
	hl(0, "@module.definition", { link = "Type" })

	-- Treesitter const
	hl(0, "@constant", { fg = colors.gray })
	hl(0, "@constant.builtin", { fg = colors.gray })

	-- Treesitter class
	hl(0, "@type", { fg = colors.gray })
	hl(0, "@type.definition", { link = "Type" })

	-- Treesitter string
	hl(0, "@string.escape", { link = "String" })

	-- Lua specific
	hl(0, "@variable.lua", { fg = colors.gray })
	hl(0, "@property.lua", { fg = colors.gray })
	hl(0, "@constructor.lua", { link = "Bracket" })
	hl(0, "luaTable", { link = "Bracket" })
	hl(0, "luaParen", { link = "Bracket" })
	hl(0, "luaFunc", { link = "Function" })

	-- Python specific
	hl(0, "@attribute.python", {})
	hl(0, "@NonePy.python", { link = "Constant" })
	hl(0, "@assertpy", { link = "Operator" })

	-- Rust specific
	hl(0, "@keyword.modifier.rust", { fg = colors.gray })
	hl(0, "@attribute.rust", { fg = colors.gray })
	hl(0, "@punctuation.special.rust", { link = "Operator" })

	-- Bash specific
	hl(0, "@variable.parameter.bash", { link = "String" })

	-- Dockerfile specific
	hl(0, "@property.dockerfile", {})

	-- Yaml specific
	hl(0, "@property.yaml", { fg = colors.gray })
	hl(0, "@label.yaml", { fg = colors.gray })
	hl(0, "@property.dockerfile", {})

	-- Elixir specific
	hl(0, "@impl.keyword.elixir", { link = "Operator" })
	hl(0, "@keyword.do.elixir", { link = "Operator" })
	hl(0, "@dot.elixir", { fg = colors.gray })
	hl(0, "@constant.builtin.elixir", { link = "Constant" })
	hl(0, "@string.special.elixir", { fg = colors.gray })

	-- JSON specific
	hl(0, "@property.json", { fg = colors.gray })

	-- TS specific
	hl(0, "@operator.decorator.typescript", { link = "Operator" })
	hl(0, "@constructor.definition.typescript", { link = "Keyword" })

	-- JS specific
	hl(0, "@tag.delimiter.javascript", { link = "Operator" })
	hl(0, "@tag.attribute.javascript", { link = "Function" })
	hl(0, "@constructor.definition.javascript", { link = "Keyword" })

	-- HTML specific
	hl(0, "@tag.attribute.html", { link = "Function" })
	hl(0, "@tag.delimiter.html", { link = "Operator" })
	hl(0, "@markup.heading.html", { fg = colors.gray })
	hl(0, "@markup.heading.1.html", { fg = colors.gray })
	hl(0, "@markup.heading.2.html", { fg = colors.gray })
	hl(0, "@markup.heading.3.html", { fg = colors.gray })
	hl(0, "@markup.heading.4.html", { fg = colors.gray })
	hl(0, "@markup.heading.5.html", { fg = colors.gray })
	hl(0, "@markup.link.label.html", { fg = colors.gray })

	-- CSS specific
	hl(0, "@property.css", { fg = colors.gray })
	hl(0, "@function.css", { fg = colors.gray })

	hl(0, "@attribute.css", { link = "Function" })
	hl(0, "@tag.attribute.css", { link = "Function" })
	hl(0, "@constant.css", { link = "Function" })
	hl(0, "@tag.css", { link = "Type" })
	hl(0, "@color.css", { link = "Constant" })
	hl(0, "@unit.css", { link = "Keyword" })

	hl(0, "@type.css", { link = "Function" })
	hl(0, "@type.delimiter.css", { link = "Function" })
	hl(0, "@punctuation.delimiter.css", {})

	-- Java specific
	hl(0, "@constructor.java", { link = "Function" })
	hl(0, "@operator.decorator.java", { link = "Operator" })
	hl(0, "@operator.access.java", { fg = colors.gray })

	-- C# specific
	hl(0, "@module.c_sharp", { link = "Type" })
	hl(0, "@property.c_sharp", { fg = colors.gray })
	hl(0, "@constructor.c_sharp", { link = "Function" })
	hl(0, "@constant.builtin.c_sharp", { link = "Constant" })
	hl(0, "@function.question", { fg = colors.gray })

	-- C++ specific
	hl(0, "@property.cpp", { fg = colors.gray })
	hl(0, "@operator.dot.cpp", { fg = colors.gray })

	-- C specific
	hl(0, "@property.c", { fg = colors.gray })
	hl(0, "@label.c", { fg = colors.gray })
	hl(0, "@operator.dot.c", { fg = colors.gray })

	-- TOML specific
	hl(0, "@property.toml", { fg = colors.gray })
	hl(0, "@string.special.toml", { link = "String" })

	-- Ruby specific
	hl(0, "@function.builtin.ruby", { link = "Keyword" })
	hl(0, "@string.special.symbol.ruby", { link = "String" })

	-- PHP specific
	hl(0, "@property.php", { fg = colors.gray })

	-- Go specific
	hl(0, "@property.go", { fg = colors.gray })

	-- Dart specific
	hl(0, "@property.dart", { fg = colors.gray })

	-- Solidity specific
	hl(0, "@constructor.solidity", { link = "Keyword" })

	-- SCSS specific
	hl(0, "@property.scss", { fg = colors.gray })
	hl(0, "@function.scss", { fg = colors.gray })
	hl(0, "@function.definition.scss", { link = "Function" })
	hl(0, "@string.scss", { fg = colors.gray })

	hl(0, "@attribute.scss", { link = "Function" })
	hl(0, "@tag.attribute.scss", { link = "Function" })
	hl(0, "@constant.scss", { link = "Function" })
	hl(0, "@tag.scss", { link = "Type" })
	hl(0, "@color.scss", { link = "Constant" })
	hl(0, "@unit.scss", { link = "Keyword" })

	hl(0, "@type.scss", { link = "Function" })
	hl(0, "@type.delimiter.scss", { link = "Function" })
	hl(0, "@punctuation.delimiter.scss", {})

	-- Bash specific
	hl(0, "@variable.parameter.bash", { fg = colors.gray })
	hl(0, "@keyword.import.bash", { fg = colors.gray })

	-- Erlang specific
	hl(0, "@function.erlang", { fg = colors.gray })
	hl(0, "@function.definition.erlang", { link = "Function" })
	hl(0, "@operator.colon.erlang", { fg = colors.gray })

	-- Clojure specific
	hl(0, "@function.method.clojure", { fg = colors.gray })

	-- Haskell specific
	hl(0, "@operator.gray.haskell", { fg = colors.gray })
	hl(0, "@keyword.directive", { fg = colors.gray })
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

# pustota.nvim

**pustota.nvim** - it is a port of the same name minimalist VSCode theme for neovim ([original repo](https://github.com/sobolevn/pustota)).

![pustota](https://raw.githubusercontent.com/igor-gorohovsky/pustota.nvim/master/assets/minimal.png)

## Supported Languages
All languages supported, but tested only on:

- Python
- Rust
- Elixir
- Lua
- Dockerfile
- YAML
- tbd...

Experience may differ from original theme for other languages

## Installation
**Note: For correct appearance, a treesitter with highlighting enabled is required.**

lazy.nvim
```lua
{ "igor-gorohovsky/pustota.nvim", version = "*", dependencies = {"nvim-treesitter/nvim-treesitter"} }
```

## Configuration
Recommended but not required `indent-blankline.nvim` config:

```lua
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
				highlight = "Indent",
			},
		},
		config = function(_, opts)
			require("pustota").ibl_setup()
			require("ibl").setup(opts)
		end,
	},
}

```

## Usage
```vim
colorscheme pustota
```
```lua
vim.cmd.colorscheme("pustota")
```


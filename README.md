# pustota.nvim

**pustota.nvim** - it is a port of the same name minimalist VSCode theme for neovim ([original repo](https://github.com/sobolevn/pustota)).

![pustota](https://raw.githubusercontent.com/igor-gorohovsky/pustota.nvim/master/assets/minimal.png)

## Supported Languages
All languages supported, but tested only on:

- Python
- Lua
- tbd...

Experience may differ from original theme for other languages

## Installation
**Note: For correct appearance, a treesitter with highlighting enabled is required.**

lazy.nvim
```lua
{ "igor-gorohovsky/pustota.nvim", dependencies = {"nvim-treesitter/nvim-treesitter"} }
```
mini.deps
```lua
add({ source = "igor-gorohovsky/pustota.nvim", depends = {"nvim-treesitter/nvim-treesitter"})
```

packer.nvim
```lua
use({"igor-gorohovsky/pustota.nvim", requires = {"nvim-treesitter/nvim-treesitter"})
```

## Usage
```vim
colorscheme pustota
```
```lua
vim.cmd.colorscheme("pustota")
```


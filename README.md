# pustota.nvim

pustota.nvim - it is a port of the same name minimalist VSCode theme for neovim ([original repo](https://github.com/sobolevn/pustota)).
[pustota](https://raw.githubusercontent.com/igor-gorohovsky/pustota.nvim/master/assets/minimal.png)

## Supported Languages
All languages supported, but tested only on:

- Python
- Lua
- tbd...

Experience can be different from original theme for other languages

## Installation
lazy.nvim
```lua
{ "igor-gorohovsky/pustota.nvim" }
```
mini.deps
```lua
add({ source = "igor-gorohovsky/pustota.nvim" })
```

packer.nvim
```lua
use({"igor-gorohovsky/pustota.nvim"})
```

## Usage
```vim
colorscheme pustota
```
```lua
vim.cmd.colorscheme("pustota")
```


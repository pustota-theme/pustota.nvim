# pustota.nvim

A clean, minimalist Neovim colorscheme inspired by the original [pustota VSCode theme](https://github.com/sobolevn/pustota). Designed to keep you focused on writing code without visual distractions.

--------------------------------------------------------------------------------
![pustota.nvim screenshot](https://raw.githubusercontent.com/igor-gorohovsky/pustota.nvim/master/assets/minimal.png)

## Features
- Distraction-free, minimalist aesthetic
- Consistent and calm color palette
- Treesitter-powered syntax highlighting
- Great for Python, Rust, Elixir, Lua and more
- Closely matches the original VSCode theme (behavior for untested languages may vary)

## Tested languages
- Python
- TS/TSX
- JS/JSX
- HTML
- CSS
- Rust
- C++
- Elixir
- Lua
- JSON
- Dockerfile
- YAML

## Installation
For the best experience, ensure you have Treesitter installed and highlighting enabled.  
Example with [lazy.nvim]:

```lua
{
    "pustota-theme/pustota.nvim",
    version = "*",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
},
```

## Configuration
Recommended (but optional) configuration with [indent-blankline.nvim]:

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
            require("pustota").ibl_setup()  -- Optional built-in integration
            require("ibl").setup(opts)
        end,
    },
}
```

## Usage
Once installed, select it as your colorscheme:

```vim
colorscheme pustota
```
or in Lua:
```lua
vim.cmd.colorscheme("pustota")
```

--------------------------------------------------------------------------------
Feel free to open an issue or pull request if you notice any missing highlights or inconsistencies. Happy coding!

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
- Go
- TS/TSX
- JS/JSX
- HTML
- PHP
- CSS
- SCSS
- C
- C++
- C#
- Java
- Scala
- Kotlin
- Ruby
- Dart
- Rust
- Erlang
- Elixir
- Clojure
- Haskell
- Lua
- Solidity
- JSON
- Dockerfile
- YAML
- TOML
- Bash
- SQL

## Integrations
- lualine.nvim
- tbd...

## Requirements
- Neovim 0.10+
- nvim-treesitter

## Installation

**Important:** This colorscheme relies on Treesitter for syntax highlighting. Make sure you have [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) installed with `highlight` enabled.

Example with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        highlight = { enabled = true },
    },
},
{
    "pustota-theme/pustota.nvim",
    version = "*",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
},
```

## Configuration

**Important:** For the best experience with this colorscheme, disable semantic highlighting from your LSP by adding this to your LSP `on_attach` function:

```lua
config.on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    -- your other on_attach logic here
end
```

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

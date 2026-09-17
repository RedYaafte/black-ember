# Black Ember for Neovim

Black Ember is a warm, low-glare dark colorscheme: charcoal surfaces, aged
bronze emphasis, and restrained ember highlights.

## Installation

With `lazy.nvim`:

```lua
{
  "yafte/black-ember",
  name = "black-ember",
  priority = 1000,
  config = function()
    require("black-ember").setup({
      transparent = false,
      italic_comments = true,
    })
    vim.cmd.colorscheme("black-ember")
  end,
}
```

## Options

- `transparent` — Do not set a background for normal editing windows.
- `italic_comments` — Render comments and special comments in italic.

The theme covers Neovim UI groups, Tree-sitter, diagnostics, diffs, GitSigns,
Telescope and `nvim-cmp`. Its color roles mirror `palette/black-ember.toml` at
the repository root.

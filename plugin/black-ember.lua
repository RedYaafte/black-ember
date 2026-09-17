-- Make the Neovim implementation discoverable when this monorepo is installed
-- directly by a plugin manager.
local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fn.fnamemodify(source, ":h:h")
local theme_dir = root .. "/nvim"

if vim.fn.isdirectory(theme_dir) == 1 and not vim.o.runtimepath:find(theme_dir, 1, true) then
  vim.opt.runtimepath:append(theme_dir)
end

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Swap functionality of ctrl-r and r
vim.keymap.set('n', 'r', '<C-r>')
vim.keymap.set('n', '<C-r>', 'r')

-- Change working directory
vim.keymap.set('n', '<Leader>ch', ':cd %:p:h | pwd<CR>')

-- Save current file with elevated permissions
vim.cmd [[
  if has('win32')
    command W execute 'silent! write !gsudo busybox tee % >     nul ' <bar> edit!
  else
    command W execute 'silent! write ! sudo         tee % >/dev/null' <bar> edit!
  endif
]]

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = "\\"
vim.g.autoformat = false
vim.opt.relativenumber = false
vim.cmd([[
  if has('win32') && split(systemlist('reg query HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme')[2])[2][2]
    set bg=light
  endif
]])

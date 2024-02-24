-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

-- This intended to make the line number bg color cool in kanagawa theme
local bg_color = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg")
vim.cmd("highlight LineNr guibg=" .. bg_color)

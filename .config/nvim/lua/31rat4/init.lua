require("31rat4.highlights")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("31rat4.lazy_init")

-- !! Teme Stuff  !!
require("31rat4.theme_stuffs")

vim.api.nvim_set_option("clipboard", "unnamedplus")
-- Telescope time to show !
vim.opt.timeoutlen = 100

vim.wo.number = true
vim.wo.relativenumber = true

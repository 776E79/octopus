local opt = vim.opt

vim.g.mapleader = " "

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.compatible = false
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.textwidth = 80
opt.colorcolumn = "+1"
opt.termguicolors = true
opt.number = true
opt.cursorline = true
opt.showmatch = true
opt.splitbelow = true
opt.lazyredraw = true
opt.synmaxcol = 200
opt.comments = "sl:/*,mb:\\ *,elx:*/"

-- Highlights
vim.api.nvim_set_hl(0, "LineNr", { fg = "#9a9a9a" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true, fg = "#5a5a5a" })


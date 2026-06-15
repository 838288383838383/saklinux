-- 🌸 SakLinux Neovim Config

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.background = "dark"

-- Sakura colors
vim.cmd([[
  colorscheme default
  hi Normal guibg=#1a1a2e guifg=#FFB7C5
  hi CursorLine guibg=#3b254f
  hi LineNr guifg=#C71585
  hi CursorLineNr guifg=#FF69B4
  hi Visual guibg=#FF69B4 guifg=#1a1a2e
  hi Search guibg=#FF1493 guifg=#ffffff
  hi StatusLine guibg=#C71585 guifg=#FFB7C5
  hi Pmenu guibg=#3b254f guifg=#FFB7C5
  hi PmenuSel guibg=#FF69B4 guifg=#1a1a2e
  hi Comment guifg=#8b5a8b
  hi Constant guifg=#FF69B4
  hi String guifg=#FFB7C5
  hi Function guifg=#FF1493
  hi Keyword guifg=#C71585
  hi Statement guifg=#FF69B4
  hi Type guifg=#FF1493
]])

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>e", ":Ex<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<leader>t", ":terminal<CR>")
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>")

-- Status line
vim.opt.statusline = " 🌸 %f %m %r %= %l,%c %P"

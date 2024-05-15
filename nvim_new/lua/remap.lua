vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.g.maplocalleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.updatetime = 300
vim.o.hlsearch = false
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- Move current line / block with Alt-j/k ala vscode.
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
-- Better window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")
-- Move current line / block with Alt-j/k a la vscode.
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
-- Terminal window navigation
vim.keymap.set("n", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("n", "<C-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("n", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("n", "<C-k>", "<C-\\><C-N><C-w>k")
-- comment
vim.api.nvim_set_keymap("n", "<leader>/", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>/", "gc", { noremap = false })

vim.keymap.set("n", "<Tab>", ":tabNext<cr>")

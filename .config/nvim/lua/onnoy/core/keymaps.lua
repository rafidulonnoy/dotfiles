vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Save" })
vim.keymap.set("n", "<leader>q", vim.cmd.q, { desc = "Quit" })

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<C-d>", "<C-d>zz", {desc = "Ctrl+d will also run zz"})
keymap.set("n", "<C-u>", "<C-u>zz", {desc = "Ctrl+d will also run zz"})

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab management
-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Terminal mode
<<<<<<< HEAD
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
=======
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
>>>>>>> 0a7fc2c (final push before windows)
keymap.set({ "n", "v" }, "<leader>\\", "<cmd>terminal<CR>", { desc = "Open terminal" })
keymap.set({ "n", "v" }, "<leader>t", "<cmd>Floaterminal<CR>", { desc = "Open toggle terminal" })

-- Buffer management
keymap.set({ "n", "v" }, "<leader>x", "<cmd>bdelete!<CR>", { desc = "delete buffer" })
keymap.set({ "n", "v" }, "<leader>p", "<cmd>bp<CR>", { desc = "previous buffer" })
keymap.set({ "n", "v" }, "<leader>n", "<cmd>bn<CR>", { desc = "next buffer" })

-- Oil
keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })


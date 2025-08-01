local key = vim.keymap

vim.g.mapleader = " "

-- delete single character without copying into register
key.set("n", "x", '"_x', { desc = "delete without copy to buffer" })

-- put lines together with 'J'
key.set("n", "J", "mzJ`z", { desc = "put lines together" })

-- cursor in the middle with move files
key.set("n", "<C-d>", "<C-d>zz", { desc = "move code to down but the view in the center " })
key.set("n", "<C-u>", "<C-u>zz", { desc = "move cod to up but the view in the center" })
key.set("n", "n", "nzzzv", { desc = "move the selection code down but in the center" })
key.set("n", "N", "Nzzzv", { desc = "move the selection code up but in the center" })

-- clear search highlights
-- key.set({ "i", "n" }, "<leader>.", ":noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- select all
key.set("n", "<C-a>", "gg<S-v>G", { desc = "select all text" })
-- key.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

key.set("n", "<space><space>x", "<cmd>source %<CR>")
key.set("n", "<space>x", ":.lua<CR>")
key.set("v", "<space>x", ":lua<CR>")

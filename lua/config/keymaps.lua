-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "delete without copy to buffer" })
keymap.set("n", "<leader>d", '"_d', { desc = "delete without copy to buffer" })

-- keymap.set("n", "<leader>e", ":Explore", { desc = "toogle explore" })

keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move block of code to up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move block of code to down" })

keymap.set("n", "J", "mzJ`z", { desc = "put lines together" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move code to down but the view in the center " })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move cod to up but the view in the center" })
keymap.set("n", "n", "nzzzv", { desc = "move the selection code down but in the center" })
keymap.set("n", "N", "Nzzzv", { desc = "move the selection code up but in the center" })

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "rename the register" })

-- clear search highlights
keymap.set("n", "<leader>.", ":nohl<Return>", { desc = "Clear search highlights" })

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "select all text" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

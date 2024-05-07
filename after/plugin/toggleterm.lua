require("toggleterm").setup()

vim.keymap.set("n", [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm"<CR>')
vim.keymap.set("t", [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm"<CR>')



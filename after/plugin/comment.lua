require('Comment').setup()


local api = require('Comment.api')
vim.api.nvim_set_keymap("n", "<C-/>", "gcc", {noremap = false})
vim.api.nvim_set_keymap("v", "<C-/>", "gcc", {noremap = false})



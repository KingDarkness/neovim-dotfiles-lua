require("kommentary.config").use_extended_mappings()

vim.g.kommentary_create_default_mappings = false

vim.api.nvim_set_keymap("n", "<leader>/", "<Plug>kommentary_line_increase", {})
vim.api.nvim_set_keymap("n", "<leader>?", "<Plug>kommentary_line_decrease", {})
vim.api.nvim_set_keymap("v", "<leader>/", "<Plug>kommentary_visual_increase", {})
vim.api.nvim_set_keymap("v", "<leader>?", "<Plug>kommentary_visual_decrease", {})

require("todo-comments").setup {}
vim.api.nvim_set_keymap("n", "<leader>ft", ":TodoTelescope<cr>", {})

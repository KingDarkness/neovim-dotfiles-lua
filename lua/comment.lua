local g = vim.g -- a table to access global variables
require("nvim_comment").setup(
    {
        marker_padding = true,
        comment_empty = false,
        create_mappings = true,
        line_mapping = "<leader>/",
        operator_mapping = "<leader>/"
    }
)

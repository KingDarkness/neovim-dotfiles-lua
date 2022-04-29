local M = {}
function M.setup()
    require("harpoon").setup {
        menu = {
            width = 120
        }
    }
    require("telescope").load_extension "harpoon"
end
return M

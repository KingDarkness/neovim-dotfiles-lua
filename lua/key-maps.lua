local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- COPY EVERYTHING in the file--
map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)
-- save
map("n", "<C-s>", [[ <Cmd> w <CR>]], opt)
-- toggle numbers ---
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)
-- Close buffer
map('n', '<leader>c', [[ <Cmd> bd <CR>]], opt)
map('n', '<leader>ca', [[ <Cmd> BOnly <CR>]], opt)
-- Clean search (highlight)
map('n', '<leader><space>', [[ <Cmd> noh <CR>]], opt)
-- Switching windows
map('n', '<A-Up>', [[ <Cmd> wincmd k <CR>]], opt)
map('n', 'A-Down', [[ <Cmd> wincmd j <CR>]], opt)
map('n', 'A-Left', [[ <Cmd> wincmd h <CR>]], opt)
map('n', 'A-Right', [[ <Cmd> wincmd l <CR>]], opt)
-- tab
map("n", "<S-t>", [[<Cmd>tabnew<CR>]], opt) -- new tab
map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt) -- close tab
-- move between tabs
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
-- Split
map("n", "<leader>h", [[<Cmd>split<CR>]], opt)
map("n", "<leader>v", [[<Cmd>vsplit<CR>]], opt)

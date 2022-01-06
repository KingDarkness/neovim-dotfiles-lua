local utils = require("utils")

local opt = {}

-- open terminal
-- utils.map_key("n", "<C-T>", [[<Cmd> split term://$SHELL | resize 10 <CR>]], opt) --  bottom
-- back to nomal mode on terminal
utils.map_key("t", "<C-n>", [[<C-\><C-n>]], {silent = true})
-- save
utils.map_key("n", "<C-s>", [[ <Cmd> w <CR>]], opt)
-- Close buffer
utils.map_key("n", "<C-w>", [[ <Cmd>bd<CR>]], opt)
utils.map_key("n", "<S-W>", [[ <Cmd>BOnly<CR>]], opt)
-- Switching windows
utils.map_key("n", "<A-Up>", [[ <Cmd> wincmd k <CR>]], opt)
utils.map_key("n", "<A-Down>", [[ <Cmd> wincmd j <CR>]], opt)
utils.map_key("n", "<A-Left>", [[ <Cmd> wincmd h <CR>]], opt)
utils.map_key("n", "<A-Right>", [[ <Cmd> wincmd l <CR>]], opt)
-- tab
utils.map_key("n", "<S-t>", [[<Cmd>tabnew<CR>]], opt) -- new tab
utils.map_key("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt) -- close tab
-- move between tabs
utils.map_key("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
utils.map_key("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
-- replace
utils.map_key("n", "<leader>rw", [[:%s/<C-r><C-w>//g<Left><Left>]], opt)

-- Vmap for maintain Visual Mode after shifting > and <
vim.api.nvim_exec(
    [[
  vmap < <gv
  vmap > >gv

  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv
  vnoremap <C-S-UP> :m '<-2<CR>gv=gv
  vnoremap <C-S-DOWN> :m '>+1<CR>gv=gv

  nnoremap <C-S-DOWN> :m .+1<CR>==
  nnoremap <C-S-UP> :m .-2<CR>==
  inoremap <C-S-DOWN> <Esc>:m .+1<CR>==gi
  inoremap <C-S-UP> <Esc>:m .-2<CR>==gi
]],
    false
)

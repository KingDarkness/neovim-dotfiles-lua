local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- open terminal
map("n", "<C-T>", [[<Cmd> split term://$SHELL | resize 10 <CR>]], opt) --  bottom
-- back to nomal mode on terminal
map("t", "<C-n>", [[<C-\><C-n>]], {silent=true})
-- COPY EVERYTHING in the file--
map('n', '<C-a>', [[ <Cmd> %y+<CR>]], opt)
-- save
map('n', '<C-s>', [[ <Cmd> w <CR>]], opt)
-- toggle numbers ---
map('n', '<leader>n', [[ <Cmd> set nu!<CR>]], opt)
-- Close buffer
map('n', '<leader>c', [[ <Cmd> bdelete <CR>]], opt)
map('n', '<leader>ca', [[ <Cmd> BOnly <CR>]], opt)
-- Clean search (highlight)
map('n', '<leader><space>', [[ <Cmd> noh <CR>]], opt)
-- Switching windows
map('n', '<A-Up>', [[ <Cmd> wincmd k <CR>]], opt)
map('n', '<A-Down>', [[ <Cmd> wincmd j <CR>]], opt)
map('n', '<A-Left>', [[ <Cmd> wincmd h <CR>]], opt)
map('n', '<A-Right>', [[ <Cmd> wincmd l <CR>]], opt)
-- tab
map('n', '<S-t>', [[<Cmd>tabnew<CR>]], opt) -- new tab
map('n', '<S-x>', [[<Cmd>bdelete<CR>]], opt) -- close tab
-- move between tabs
map('n', '<TAB>', [[<Cmd>BufferLineCycleNext<CR>]], opt)
map('n', '<S-TAB>', [[<Cmd>BufferLineCyclePrev<CR>]], opt)
-- Split
map('n', '<leader>h', [[<Cmd>split<CR>]], opt)
map('n', '<leader>v', [[<Cmd>vsplit<CR>]], opt)

-- EasyAlign
vim.api.nvim_exec([[
  xmap <leader>a <Plug>(EasyAlign)
  nmap <leader>a <Plug>(EasyAlign)
]], false)

-- Vmap for maintain Visual Mode after shifting > and <
-- Move visual block
vim.api.nvim_exec([[
  vmap < <gv
  vmap > >gv

  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv
  vnoremap <C-S-UP> :m '<-2<CR>gv=gv
  vnoremap <C-S-DOWN> :m '>+1<CR>gv=gv
]], false)

-- search

-- replace
vim.api.nvim_exec([[
  vnoremap <leader>R ''y:%s/<C-R>=escape(@', '/\')<CR>//g<Left><Left>
  vnoremap <leader>r ''y:%s/<C-R>=expand('<cword>')<CR>//g<Left><Left>
]], false)

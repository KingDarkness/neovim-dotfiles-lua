local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- open terminal
-- map("n", "<C-T>", [[<Cmd> split term://$SHELL | resize 10 <CR>]], opt) --  bottom
-- back to nomal mode on terminal
map("t", "<C-n>", [[<C-\><C-n>]], {silent = true})
-- COPY EVERYTHING in the file--
map("n", "<leader>ya", [[ <Cmd> %y+<CR>]], opt)
-- save
map("n", "<C-s>", [[ <Cmd> w <CR>]], opt)
-- toggle numbers ---
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)
-- Close buffer
map("n", "<leader>c", [[ <Cmd> bdelete <CR>]], opt)
map("n", "<leader>ca", [[ <Cmd> BOnly <CR>]], opt)
-- Clean search (highlight)
map("n", "<leader><space>", [[ <Cmd> noh <CR>]], opt)
-- Switching windows
map("n", "<A-Up>", [[ <Cmd> wincmd k <CR>]], opt)
map("n", "<A-Down>", [[ <Cmd> wincmd j <CR>]], opt)
map("n", "<A-Left>", [[ <Cmd> wincmd h <CR>]], opt)
map("n", "<A-Right>", [[ <Cmd> wincmd l <CR>]], opt)
-- tab
map("n", "<S-t>", [[<Cmd>tabnew<CR>]], opt) -- new tab
map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt) -- close tab
-- move between tabs
map("n", "<TAB>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-TAB>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
-- Split
map("n", "<leader>h", [[<Cmd>split<CR>]], opt)
map("n", "<leader>v", [[<Cmd>vsplit<CR>]], opt)

-- replace
map("v", "<leader>r", [[:%s/<C-r><C-w>//g<Left><Left>]], opt)
map("v", "<leader>R", [[:%s/<C-R>=escape(@", '/\')<CR>//g<Left><Left>]], opt)
map("n", "<leader>R", [[:%s/<C-r><C-w>//g<Left><Left>]], opt)

-- search
map(
    "v",
    "<leader>f",
    [[:<C-U> let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR> gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>gVzv:call setreg('"', old_reg, old_regtype)<CR>]],
    {silent = true}
)
map("n", "<leader>f", [[:/<C-r><C-w><CR>]], opt)

-- EasyAlign
vim.api.nvim_exec([[
  xmap <leader>a <Plug>(EasyAlign)
  nmap <leader>a <Plug>(EasyAlign)
]], false)

-- Vmap for maintain Visual Mode after shifting > and <
-- Move visual block
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

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
utils.map_key("n", "<leader>Rw", [[:lua NomalReplace("all")<CR>]], opt)
utils.map_key("n", "<leader>Rcw", [[:lua NomalReplace("all", "confirm")<CR>]], opt)
utils.map_key("n", "<leader>Rl", [[:lua NomalReplace("line")<CR>]], opt)
utils.map_key("n", "<leader>Rcl", [[::lua NomalReplace("line", "confirm")<CR>]], opt)
utils.map_key("n", "<leader>Re", [[:lua NomalReplace("here_to_end")<CR>]], opt)
utils.map_key("n", "<leader>Rce", [[::lua NomalReplace("here_to_end", "confirm")<CR>]], opt)
utils.map_key("n", "<leader>Rn", [[:lua NomalReplace("here_next_lines")<CR>]], opt)
utils.map_key("n", "<leader>Rcn", [[:lua NomalReplace("here_next_lines", "confirm")<CR>]], opt)

utils.map_key("v", "<leader>Rw", [[:lua VisualReplace("all")<CR>]], opt)
utils.map_key("v", "<leader>Rcw", [[:lua VisualReplace("all", "confirm")<CR>]], opt)
utils.map_key("v", "<leader>Rl", [[:lua VisualReplace("line")<CR>]], opt)
utils.map_key("v", "<leader>Rcl", [[::lua VisualReplace("line", "confirm")<CR>]], opt)
utils.map_key("v", "<leader>Re", [[:lua VisualReplace("here_to_end")<CR>]], opt)
utils.map_key("v", "<leader>Rce", [[::lua VisualReplace("here_to_end", "confirm")<CR>]], opt)
utils.map_key("v", "<leader>Rn", [[:lua VisualReplace("here_next_lines")<CR>]], opt)
utils.map_key("v", "<leader>Rcn", [[:lua VisualReplace("here_next_lines", "confirm")<CR>]], opt)
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

function GetVisualSelection()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    local selected = table.concat(lines, "\n")
    selected = vim.fn.escape(selected, [[/\.*$^~[]])
    return selected
end

function VisualReplace(mode, confirm)
    -- default mode = all
    local prefix = [[:%s/]]
    if mode == "line" then
        prefix = [[:s/]]
    elseif mode == "here_to_end" then
        prefix = [[:.,$s/]]
    elseif mode == "here_next_lines" then
        vim.ui.input(
            {prompt = "Enter number next line: "},
            function(lines)
                prefix = [[:.,+]] .. lines .. [[s/]]
            end
        )
    end

    local suffix = [[//g<Left><Left>]]
    if confirm == "confirm" then
        suffix = [[//gc<Left><Left><Left>]]
    end

    local selected = GetVisualSelection()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(prefix .. selected .. suffix, true, false, true))
end

function NomalReplace(mode, confirm)
    -- default mode = all
    local prefix = [[:%s/]]
    if mode == "line" then
        prefix = [[:s/]]
    elseif mode == "here_to_end" then
        prefix = [[:.,$s/]]
    elseif mode == "here_next_lines" then
        vim.ui.input(
            {prompt = "Enter number next line: "},
            function(lines)
                prefix = [[:.,+]] .. lines .. [[s/]]
            end
        )
    end

    local suffix = [[//g<Left><Left>]]
    if confirm == "confirm" then
        suffix = [[//gc<Left><Left><Left>]]
    end

    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(prefix .. [[<C-r><C-w>]] .. suffix, true, false, true))
end

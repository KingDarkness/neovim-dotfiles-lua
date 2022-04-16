local M = {}
local fmt = string.format
local end_of_line = "__n__"

-- {
--     nargs = 1, optional
--     name = "name of command" required
--     cmd = "command" required,
-- },
function M.setup_commands(cmds, require_file)
    for _, cmd in ipairs(cmds) do
        local nargs = cmd.nargs and fmt("-nargs=%d", cmd.nargs) or ""
        vim.cmd(fmt('command! %s %s lua require("%s").%s', nargs, cmd.name, require_file, cmd.cmd))
    end
end

function M.map_key(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.get_absolute_forder_path()
    return vim.api.nvim_exec("echo substitute(expand('%:p:h'), getcwd(), '', '')", true)
end

function M.get_absolute_path()
    return vim.api.nvim_exec([[echo substitute(expand('%"d'), getcwd(), '', '')]], true)
end

function M.isMacOs()
    return vim.loop.os_uname().sysname == "Darwin"
end

function M.visualReplace(mode, confirm)
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

    local selected = M.getVisualSelection()
    -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes(prefix .. selected .. suffix, true, false, true))
    vim.fn.feedkeys(
        vim.fn.substitute(
            vim.api.nvim_replace_termcodes(prefix .. selected .. suffix, true, false, true),
            end_of_line,
            [[\\n]],
            "g"
        )
    )
end

function M.normalReplace(mode, confirm)
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

function M.visualSearch()
    local query = M.getVisualSelection()
    query = vim.fn.substitute(query, end_of_line, [[\\n]], "g")
    vim.api.nvim_exec([[:/]] .. query, false)
end

function M.getVisualSelection()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")
    local lines = vim.fn.getline(start_pos[1], end_pos[1])
    -- add when only select in 1 line
    local plusEnd = 0
    local plusStart = 1
    if #lines == 0 then
        return ""
    elseif #lines == 1 then
        plusEnd = 1
        plusStart = 1
    end
    lines[#lines] = string.sub(lines[#lines], 0, end_pos[2] + plusEnd)
    lines[1] = string.sub(lines[1], start_pos[2] + plusStart, string.len(lines[1]))
    local query = table.concat(lines, end_of_line)
    query = vim.fn.escape(query, [[/\.*$^~[]])
    return query
end

return M

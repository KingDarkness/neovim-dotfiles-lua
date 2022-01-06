local M = {}
local fmt = string.format

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

return M

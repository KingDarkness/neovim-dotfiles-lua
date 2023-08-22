local M = {}
local utils = require("utils")

function M.setup()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    require("auto-session").setup({
        log_level = "info",
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("config") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = nil,
        auto_restore_enabled = true,
        auto_session_suppress_dirs = nil,
        pre_save_cmds = {
            function()
                require("nvim-tree.view").close()
                require("spectre").close()
            end,
        },
    })
    require("session-lens").setup({
        prompt_title = "YOUR SESSIONS",
    })

    utils.map_key("n", "<Leader>fs", [[<Cmd>:SearchSession<CR>]], {})
    utils.map_key("n", "<Leader>ss", [[<Cmd>:SaveSession<CR>]], {})
    utils.map_key("n", "<Leader>ds", [[<Cmd>:DeleteSession<CR>]], {})
end

return M

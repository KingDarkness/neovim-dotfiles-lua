local g = vim.g -- a table to access global variables
g.user_emmet_leader_key = ","
g.user_emmet_mode = "i"
g.user_emmet_install_global = 0

vim.api.nvim_exec([[
  autocmd FileType html,css EmmetInstall
]], false)

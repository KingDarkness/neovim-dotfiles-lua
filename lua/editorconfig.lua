local g = vim.g -- a table to access global variables

local handle = io.popen("which editorconfig")
local result = handle:read("*a")
g.EditorConfig_exec_path = result
g.EditorConfig_core_mode = "external_command"

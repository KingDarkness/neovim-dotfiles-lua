local g = vim.g      -- a table to access global variables
g.auto_save = 1
g.auto_save_events = { 'InsertLeave' }
-- g.auto_save_events = ['InsertLeave', 'TextChanged']
g.auto_save_write_all_buffers = 1

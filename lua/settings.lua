-- vim.o for setting global options
-- vim.bo for setting buffer-scoped options
-- vim.wo for setting window-scoped options
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

local base16 = require "base16"
base16(base16.themes["onedark"], true)
cmd "syntax on"
cmd "set nowrap"

opt("o", "encoding", "utf-8")
opt("o", "fileencoding", "utf-8")
opt("o", "fileencodings", "utf-8")
opt("o", "backspace", "indent,eol,start")
opt("b", "tabstop", 4)
opt("b", "softtabstop", 0)
opt("b", "shiftwidth", 4)
opt("b", "expandtab", true)
opt("b", "smartindent", true)
opt("b", "autoindent", true)
-- Enable hidden buffers
opt("o", "hidden", true)
-- Makes popup menu smaller
opt("o", "pumheight", 10)
-- So that I can see `` in markdown files
opt("o", "conceallevel", 0)
-- Give more space for displaying messages
opt("o", "cmdheight", 2)
opt("w", "signcolumn", "yes")
-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt("o", "updatetime", 500)
opt("o", "timeoutlen", 500)
-- Searching
opt("o", "hlsearch", true)
opt("o", "incsearch", true)
opt("o", "autowriteall", true)
opt("o", "ruler", true)
opt("w", "number", true)
opt("o", "relativenumber", true)
opt("o", "numberwidth", 2)
opt("o", "termguicolors", true)
opt("o", "background", "dark")
opt("o", "mousemodel", "popup")
opt("o", "wildmenu", true)
-- Wait to redraw
opt("o", "lazyredraw", true)
opt("o", "ttyfast", true)
-- Scroll 8 lines at a time at bottom/top
opt("o", "scrolljump", 8)

-- Status bar
opt("o", "laststatus", 2)

-- Use modeline overrides
opt("o", "modeline", true)
opt("o", "modelines", 10)

opt("o", "title", true)
opt("o", "titleold", "Terminal")
opt("o", "titlestring", "%F")

opt("o", "splitbelow", true)
opt("o", "splitright", true)

opt("w", "cul", true)

opt("o", "wildmode", "list:longest,list:full")

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
  au BufEnter term://* setlocal nonumber
]], false)
-- fix autoindent not working
vim.api.nvim_command(
    [[
  au TermEnter * setlocal scrolloff=0
  au TermLeave * setlocal scrolloff=3

  augroup AutoIndent
    autocmd BufEnter * :set smartindent autoindent
  augroup END
]]
)

vim.cmd(
    [[
  filetype plugin indent on
  set smartindent
  set autoindent

  set nobackup
  set nowritebackup
  set noswapfile

  set clipboard=unnamed,unnamedplus
  set fileformats=unix,dos,mac

  highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
  highlight link multiple_cursors_visual Visual

  set shortmess+=c
]]
)

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

return M

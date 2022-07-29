local M = {}
local cmp = require "cmp"

vim.o.completeopt = "menu,menuone,noselect"

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

function M.setup()
    vim.api.nvim_exec(
        [[
            let g:vsnip_filetypes = {}
            let g:vsnip_filetypes.javascriptreact = ['javascript']
            let g:vsnip_filetypes.vue = [ 'vue', 'javascript', 'typescript' ]
            let g:vsnip_filetypes.typescriptreact = [ 'typescript' ]

            " gray
            highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
            " blue
            highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
            highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
            " light blue
            highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
            highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
            highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
            " pink
            highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
            highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
            " front
            highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
            highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
            highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
    ]],
        false
    )

    cmp.setup(
        {
            snippet = {
                expand = function(args)
                    -- For `vsnip` user.
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

                    -- For `luasnip` user.
                    -- require("luasnip").lsp_expand(args.body)

                    -- For `ultisnips` user.
                    -- vim.fn["UltiSnips#Anon"](args.body)
                end
            },
            mapping = cmp.mapping.preset.insert(
                {
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm(
                        {
                            select = true,
                            behavior = cmp.ConfirmBehavior.Insert
                        }
                    ),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif vim.fn["vsnip#available"](1) == 1 then
                                feedkey("<Plug>(vsnip-expand-or-jump)", "")
                            elseif has_words_before() then
                                cmp.complete()
                            else
                                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                            end
                        end,
                        {"i", "s"}
                    ),
                    ["<S-Tab>"] = cmp.mapping(
                        function()
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                                feedkey("<Plug>(vsnip-jump-prev)", "")
                            end
                        end,
                        {"i", "s"}
                    )
                }
            ),
            sources = cmp.config.sources(
                {
                    {name = "nvim_lsp"},
                    -- For vsnip user.
                    {name = "vsnip"},
                    -- For luasnip user.
                    -- {name = "luasnip"},
                    -- For ultisnips user.
                    -- { name = 'ultisnips' },
                    {name = "treesitter"},
                    {name = "path"},
                    {name = "buffer"},
                    {name = "nvim_lsp_signature_help"}
                }
            ),
            formatting = {
                format = function(entry, vim_item)
                    -- fancy icons and a name of kind
                    vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
                    -- set a name for each source
                    vim_item.menu =
                        ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        vsnip = "[Vsnip]",
                        nvim_lua = "[Lua]",
                        path = "[Path]",
                        treesitter = "[Treesitter]"
                    })[entry.source.name]
                    return vim_item
                end
            },
            completion = {completeopt = "menu,menuone,noinsert"},
            enabled = function()
                if vim.bo.buftype == "prompt" then
                    return false
                end
                -- disable completion in comments
                local context = require "cmp.config.context"
                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == "c" then
                    return true
                else
                    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                end
            end
        }
    )
    require "cmp".setup.cmdline(
        ":",
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    {name = "cmdline"}
                }
            )
        }
    )

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(
        "/",
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    {name = "buffer"}
                }
            )
        }
    )
end

return M

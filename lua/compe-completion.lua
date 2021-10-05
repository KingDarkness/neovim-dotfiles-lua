vim.o.completeopt = "menu,menuone,noselect"
local cmp = require "cmp"

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

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
        mapping = {
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm(
                {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }
            ),
            ["<Tab>"] = cmp.mapping(
                function(fallback)
                    if vim.fn.pumvisible() == 1 then
                        vim.fn.feedkeys(t("<C-n>"), "n")
                    elseif check_back_space() then
                        vim.fn.feedkeys(t("<tab>"), "n")
                    else
                        fallback()
                    end
                end,
                {"i", "s"}
            ),
            ["<S-Tab>"] = cmp.mapping(
                function(fallback)
                    if vim.fn.pumvisible() == 1 then
                        vim.fn.feedkeys(t("<C-p>"), "n")
                    else
                        fallback()
                    end
                end,
                {"i", "s"}
            )
        },
        sources = {
            {name = "nvim_lsp"},
            -- For vsnip user.
            {name = "vsnip"},
            -- For luasnip user.
            -- {name = "luasnip"},
            -- For ultisnips user.
            -- { name = 'ultisnips' },
            {name = "treesitter"},
            {name = "path"},
            {name = "buffer"}
        },
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
        completion = {completeopt = "menu,menuone,noinsert"}
    }
)

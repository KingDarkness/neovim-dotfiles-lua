local g = vim.g -- a table to access global variables

g.vue_pre_processors = "detect_on_enter"
g.vim_vue_plugin_config = {
    syntax = {
        template = {"html"},
        script = {"javascript"},
        style = {"css"},
        i18n = {"json"},
        docs = {"markdown"}
    },
    full_syntax = {"css", "html"},
    attribute = 1,
    keyword = 1
}

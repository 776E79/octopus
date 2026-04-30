require('nvim-tree').setup({
    sync_root_with_cwd = true,
    view = { 
        width = 40, 
        side = 'left',
        signcolumn = "yes",
    },
    update_focused_file = { enable = true },
    git = { ignore = false },
    filters = {
        custom = { "^.git$" },
    },
    renderer = {
        special_files = {},
        highlight_opened_files = "all",
        root_folder_label = ":t",
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            webdev_colors = true,
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                folder = {
                    arrow_closed = "", -- Chevron Right
                    arrow_open = "",   -- Chevron Down
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                },
            },
        },
    },
})


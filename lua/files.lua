require('nvim-tree').setup({
    sync_root_with_cwd = true,
    view = { 
        width = 40, 
        side = 'left',
        signcolumn = "no",
    },
    update_focused_file = { enable = true },
    git = { ignore = false },
    renderer = {
        special_files = {},
        highlight_opened_files = "all",
        root_folder_label = false,
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
            -- CORRECTED: These are now direct children of 'icons'
            webdev_colors = true,
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                -- Your Nerd Font "Indicators"
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


require('nvim-tree').setup({
    renderer = {
        icons = { show = { file = false, folder = false, folder_arrow = false }},
        indent_markers = { enable = true, inline_arrows = false },
    },
    sync_root_with_cwd = true,
    view = { width = 40, side = 'left' },
    update_focused_file = { enable = true },
})


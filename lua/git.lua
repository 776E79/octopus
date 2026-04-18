require("neogit").setup({
    use_icons = false,
    disable_commit_confirmation = true,
    integrations = {
        diffview = true,
        telescope = true, 
    },
    kind = "tab", 
    diff_view = "side_by_side",
    signs = {
        section = { ">", "v" }, -- Closed, Open
        item = { ">", "v" },
        hunk = { "", "" },
    },
})

require("diffview").setup({
    icons_max_width = 1,
    use_icons = false,
    signs = {
        fold_closed = ">",
        fold_open = "v",
        done = "X",
    },
    hooks = {
        diff_buf_read = function(bufnr)
            local name = "DiffView_" .. bufnr
            pcall(vim.api.nvim_buf_set_name, bufnr, name)
        end,
    },
})



vim.opt.background = "dark"
vim.cmd.colorscheme('github_dark')

require('telescope').setup({
    defaults = {
        -- This affects live_grep and other search tools
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",     -- Include hidden files
            "--glob", "!.git/*" -- Exclude .git directory
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
    pickers = {
        find_files = {
            hidden = true, 
            find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
        },
    },
})

vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#B69A9A", bg = "none" })
require("virt-column").setup({
    char = "│",
    virtcolumn = "80",
})

-- Padding between gutter and main text
vim.opt.statuscolumn = "%s%l %C"
vim.opt.signcolumn = "yes:1"
vim.opt.foldcolumn = "1"

require("ibl").setup {
    indent = {
        char = "│",
    },
    scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        injected_languages = true,
        priority = 1024,
    },
    exclude = {
        buftypes = { "terminal", "nofile" },
    },
}


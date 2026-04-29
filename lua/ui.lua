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

local border = "rounded"

-- Borders for JetBrains-like feel
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = border,
    }
)

-- Apply border to LSP signature help (parameter hints)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signatureHelp, {
        border = border,
    }
)

-- Apply border to Diagnostic floating windows
vim.diagnostic.config({
    float = { border = border },
})

require('blink.cmp').setup({
    keymap = {
        ["<Tab>"]   = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"]    = { "accept", "fallback" },
    },
    completion = {
        menu = {
            border = border,
            -- This forces the menu to use the FloatBorder highlight group
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,'..
            'CursorLine:BlinkCmpMenuSelection,Search:None',
        },
        documentation = {
            window = {
                border = border,
                winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,'..
                'CursorLine:BlinkCmpDocCursorLine,Search:None',
                auto_show = true ,
            },
            sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        },
        list = { selection = { preselect = false } },
    },
})

vim.opt.background = "light"
require('jb', {
    disable_hl_args = {
        bold = false,
        italic = false,
    },
    snacks = {
        explorer = {
            enabled = true,
        },
    },
    telescope = {
        enabled = true,
    },
    disabled_plugins = {},
    transparent = false,
})

local main_bg = "#EBEDF0"
local panel_bg = "#E1E4E8"
local gutter_bg = "#E9EEF5"
local beige_tint = "#F0EFE7"
local border_fg = "#ADB5BD"

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "jb",
    callback = function()
        -- Bold Types (The classic Eclipse look)
        vim.api.nvim_set_hl(0, "Type", { fg = "#000000", bold = true })
        vim.api.nvim_set_hl(0, "@type", { fg = "#000000", bold = true })
        vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#000000", bold = true })

        -- Keywords (Eclipse uses a specific purple/magenta)
        vim.api.nvim_set_hl(0, "Keyword", { fg = "#7f0055", bold = true })
        vim.api.nvim_set_hl(0, "@keyword", { fg = "#7f0055", bold = true })

        -- Strings (Eclipse blue/navy)
        vim.api.nvim_set_hl(0, "String", { fg = "#2a00ff" })
        vim.api.nvim_set_hl(0, "@string", { fg = "#2a00ff" })

        -- Comments (Eclipse classic green)
        vim.api.nvim_set_hl(0, "Comment", { fg = "#3f7f5f", italic = false })
        vim.api.nvim_set_hl(0, "@comment", { fg = "#3f7f5f", italic = false })

        -- Javadoc Style (Light blue/grey)
        vim.api.nvim_set_hl(0, "@comment.documentation", { fg = "#3f5fbf" })

        -- Editor and gutter
        vim.api.nvim_set_hl(0, "Normal", { bg = main_bg, force = true })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = main_bg, force = true })

        vim.api.nvim_set_hl(0, "LineNr", { fg = "#ADB5BD", bg = gutter_bg })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = gutter_bg })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = beige_tint })
        vim.api.nvim_set_hl(0, "CursorLineSign", { bg = beige_tint })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#5E81AC", bg = beige_tint, bold = true })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#D1D9E0", bg = "none" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = gutter_bg })

        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = gutter_bg, bg = main_bg })

        -- Floating windows
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = main_bg }) 
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ADB5BD", bg = main_bg })

        -- Blink completion
        vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = main_bg })
        vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = main_bg })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#ADB5BD", bg = main_bg })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#ADB5BD", bg = main_bg })

        -- Sidebars
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = panel_bg })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = panel_bg })
        vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = panel_bg, bg = panel_bg })

        -- Panels
        vim.api.nvim_set_hl(0, "DarkPanel", { bg = panel_bg })

        -- Indent guides
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#D1D9E0", nocombine = true })
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#5E81AC", bold = true, nocombine = true })

        -- NVim tree
        vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = "none", bg = "none", italic = false })
        vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#DDE2E9", bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#5E81AC", bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = "#5E81AC" })
        vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = "#ADB5BD" })
        vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#424242" })
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#5E81AC", bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeWindowPicker", { fg = "#FFFFFF", bg = "#5E81AC", bold = true })

        -- Ruler (see VirtColumn above)
        vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#C29393", bg = main_bg, force = true })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })

        -- Lsp
        vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "#DDE2E9", underline = false })
        vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "#DDE2E9", underline = false })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "#DDE2E9", underline = false })

        -- Telescope
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#5E81AC", bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_fg, bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = border_fg, bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = border_fg, bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = border_fg, bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#FFFFFF", bg = "#5E81AC", bold = true })
        vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#5E81AC", bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#5E81AC", bg = main_bg })
        vim.api.nvim_set_hl(0, "TelescopePreviewMatch", { bg = "#DDE2E9" })

        -- Remove annoying underlies in search results
        vim.api.nvim_set_hl(0, "TelescopeSelection", { 
            fg = "#5E81AC",
            bg = "#DDE2E9",
            bold = true,
            underline = false 
        })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { 
            fg = "#5E81AC", 
            bg = "#DDE2E9"
        })
        vim.api.nvim_set_hl(0, "Search", { 
            bg = "#DDE2E9", 
            fg = "NONE", 
            underline = false,
            bold = false 
        })
        local active_search = { 
            bg = "#5E81AC", 
            fg = "#FFFFFF", 
            underline = false, 
            bold = true 
        }
        vim.api.nvim_set_hl(0, "CurSearch", active_search)
        vim.api.nvim_set_hl(0, "IncSearch", active_search)
        vim.api.nvim_set_hl(0, "Substitute", { 
            bg = "#E6E5DE", 
            fg = "#5E81AC", 
            underline = false 
        })

        -- Make the theme less obnoxious by stripping background
        -- from delimeter characters.
        local special_chars = {
            "Delimiter",
            "Operator",
            "Punctuation",
            "@punctuation.bracket",
            "@punctuation.delimiter",
            "NonText",
            "Special",
        }
        for _, group in ipairs(special_chars) do
            vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
        end
        vim.api.nvim_set_hl(0, "TelescopeMatching", { 
            fg = "#5E81AC", 
            bg = "NONE", 
            bold = true, 
            underline = false 
        })
    end,
})

-- Padding between gutter and main text
vim.opt.statuscolumn = "%s%l %C"
vim.opt.signcolumn = "yes:1"
vim.opt.foldcolumn = "1"

require("ibl").setup {
    indent = {
        char = "│",
        highlight = "IblIndent",
    },
    scope = {
        enabled = true,
        highlight = "IblIndent",
        show_start = false,
        show_end = false,
        injected_languages = true,
        priority = 1024,
    },
    exclude = {
        buftypes = { "terminal", "nofile" },
    },
}

vim.cmd.colorscheme('jb')


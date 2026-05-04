require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",
        "ruff",
        "bashls",
        "clangd",
    },
})

-- clangd for c/c++ requires clangd
vim.lsp.config('clangd', {
    cmd = { 
        'clangd', 
        '--background-index', 
        '--header-insertion=never' ,
        '--function-arg-placeholders=0',
    },
    root_markers = { '.clangd', 'compile_commands.json', 'Makefile', '.git' },
})
vim.lsp.enable('clangd')

-- bash/sh requires bash-language-server and shellcheck
vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh' }
})
vim.lsp.enable('bashls')

-- pyright requires pyright-langserver and ruff
vim.lsp.config('pyright', {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", ".git" },
    settings = {
        python = {
            stubPath = "typings", 

            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "standard",

                diagnosticSeverityOverrides = {
                    reportUnusedImport = "warning",
                    reportUnusedVariable = "warning",
                },

                executionEnvironments = {
                    { root = "src" },
                },
            },
        },
    },
})
vim.lsp.enable('pyright')

-- requires ruff
vim.lsp.config('ruff', {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".git" },
    on_attach = function(client)
        client.server_capabilities.hoverProvider = false
    end,
})
vim.lsp.enable('ruff')

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "python", "bash", "lua" },
    callback = function()
        vim.opt_local.foldmethod = "syntax"
        vim.opt_local.foldlevel = 99
    end,
})

require('blink.cmp').setup({
    keymap = {
        ["<Tab>"]   = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"]    = { "accept", "fallback" },
        ["<C-s>"]   = { "show_signature", "hide_signature", "fallback" },
    },
    completion = {
        menu = {
            border = 'rounded',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,'..
            'CursorLine:BlinkCmpMenuSelection,Search:None',
            selection = { preselect = false, auto_insert = false, },
            auto_show = true,
        },
        documentation = {
            auto_show = true,
            window = {
                border = 'rounded',
                winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,'..
                'CursorLine:BlinkCmpDocCursorLine,Search:None',
            },
        },
        accept = { auto_brackets = { enabled = false, }, },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    signature = {
        enabled = true,
        window = {
            border = 'rounded',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,'..
            'CursorLine:BlinkCmpDocCursorLine,Search:None',
        },
    },
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or 'rounded'
    opts.winhighlight = opts.winhighlight or 
    'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None'

    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


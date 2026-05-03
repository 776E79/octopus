-- clangd for c/c++
-- requirements:
--  - clangd
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

-- bash/sh
-- requirements
--  - bash-language-server (core)
--  - shellcheck (linting)
vim.lsp.config('bashls', {
    cmd = { 'bash-language-server', 'start' },
    filetypes = { 'bash', 'sh' }
})
vim.lsp.enable('bashls')

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
        trigger = {
            show_on_insert_or_trigger_character = true,
        },
        window = {
            border = 'rounded',
            winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,'..
            'CursorLine:BlinkCmpDocCursorLine,Search:None',
        },
    },
})


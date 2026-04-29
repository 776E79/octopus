require("mason").setup()

require("mason-lspconfig").setup({
    -- These are the standardized names Mason uses for these LSPs
    ensure_installed = {
        "pyright",
        "ruff",
        "bashls",
        "clangd",
        "asm_lsp",
    },
})

-- clangd for c/c++
-- requirements:
--  - clangd
vim.lsp.config('clangd', {
    cmd = { 
        'clangd', 
        '--background-index', 
        '--header-insertion=never' ,
    },
    -- This is the equivalent of root_dir
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

-- Add other servers and configurations here as needed.
-- requirements:
--  - pyright or
--  python-lsp-service
-- 1. Configuration for Pyright (Type Checking & Definitions)
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


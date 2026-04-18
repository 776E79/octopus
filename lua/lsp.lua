require('Comment').setup({})

require("ibl").setup()

vim.lsp.config('clangd', {
    cmd = { 'clangd', '--background-index' },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
})

vim.lsp.enable('clangd')

require('blink.cmp').setup({
    keymap = {
        ["<Tab>"]   = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"]    = { "accept", "fallback" },
    },
    completion = {
        documentation = { auto_show = true },
        list = { selection = { preselect = false } },
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
})


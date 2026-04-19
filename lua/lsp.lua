require('Comment').setup({})

require("ibl").setup()

vim.lsp.config('clangd', {
  cmd = { 
    'clangd', 
    '--background-index', 
    '--header-insertion=never' ,
    '--log=verbose',
  },
  -- This is the equivalent of root_dir
  root_markers = { '.clangd', 'compile_commands.json', 'Makefile', '.git' },
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


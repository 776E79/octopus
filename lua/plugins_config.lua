-- Appearance
require("catppuccin").setup({ no_italic = true })
vim.cmd.colorscheme("catppuccin-frappe")

require('Comment').setup({})
require("ibl").setup()

require('grug-far').setup({
    icons = { enabled = false },
    startInInsertMode = false,
})

-- LSP (Restored original pattern)
vim.lsp.config('clangd', {
    cmd = { 'clangd', '--background-index' },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
})
vim.lsp.enable('clangd')

-- Completion
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

-- File Tree
require('nvim-tree').setup({
    renderer = {
        icons = { show = { file = false, folder = false, folder_arrow = false }},
        indent_markers = { enable = true, inline_arrows = false },
    },
    sync_root_with_cwd = true,
    view = { width = 40, side = 'left' },
    update_focused_file = { enable = true },
})

-- Git
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

-- Diff view
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

-- Telescope
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
      "--hidden",          -- Search hidden files
      "--glob", "!.git/*"  -- But ignore everything inside the .git folder
    },
  },
  pickers = {
    find_files = {
      hidden = true, 
      find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
    },
  },
})


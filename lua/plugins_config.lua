-- Appearance
-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    colorblind = {
      enable = false,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {               -- Style to be applied to different syntax groups
      comments = "italic",   -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "bold",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = true,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- setup must be called before loading
vim.cmd.colorscheme("dayfox")

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


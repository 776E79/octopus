require('core_settings')
require('plugins')

-- Identify if we are currently installing plugins (headless)
local is_headless = #vim.api.nvim_list_uis() == 0

-- ONLY load plugin-dependent modules if we have a UI (not installing)
if not is_headless then
    -- Safely load configurations here
    require('lsp')
    require('search')
    require('files')
    require('git')
    require('ui')

    -- Load utilities that depend on Telescope/Plugins
    require('tab_utils')
    require('file_utils')
    require('buffer_utils')
    require('format_utils')
    require('telescope_diff')
    require('telescope_palette')

    -- Load standard UI elements and keymaps
    require('keymaps')
    require('autocommands')
    require('statline')
    require('ui')
else
    -- In headless mode, we only want the bare minimum keymaps
    -- so we don't trigger "module not found" errors.
    print("Octopus: Headless mode detected. Skipping plugin-dependent modules.\n")
end

-- Session management options (save everything)
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Set up system clipboard
vim.opt.clipboard = "unnamedplus"

-- Force TrueColor and prevent SSH detection lag
vim.opt.termguicolors = true

-- This autocommand forces the colorscheme to re-apply 
-- once the terminal UI is fully attached over the network
vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme('github_light_default')
    end
})


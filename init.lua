require('core_settings')
require('plugins')

-- Identify if we are currently installing plugins (headless)
local is_headless = #vim.api.nvim_list_uis() == 0

-- ONLY load plugin-dependent modules if we have a UI (not installing)
if not is_headless then
    -- Safely load configurations
    require('plugins_config')

    -- Load utilities that depend on Telescope/Plugins
    require('tab_utils')
    require('run_utils')
    require('file_utils')
    require('buffer_utils')
    require('telescope_diff')
    require('telescope_palette')

    -- Load standard UI keymaps
    require('keymaps')
    require('autocommands')
else
    -- In headless mode, we only want the bare minimum keymaps
    -- so we don't trigger "module not found" errors.
    print("Octopus: Headless mode detected. Skipping plugin-dependent modules.\n")
end

-- Session management options (save everything)
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"


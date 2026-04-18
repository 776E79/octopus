local M = {}

local function script_picker(prompt, search_dir)
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    -- Ensure search_dir doesn't have a trailing slash for the 'find' command
    local clean_dir = search_dir:gsub("/$", "")
    local os_name = vim.loop.os_uname().sysname

    -- Linux (GNU find)
    if os_name == "Linux" then
        find_cmd = { 
            "find", clean_dir, 
            "-type", "f", 
            "-executable", 
            "-not", "-path", "*/.git/*" 
        }
    -- macOS, FreeBSD, AIX, Solaris (BSD/POSIX find)
    else
        find_cmd =  { 
            "find", clean_dir, 
            "-type", "f", 
            "-perm", "-0111", 
            "!", "-path", "*/.git/*" 
        }
    end

    local opts = themes.get_dropdown({
        prompt_title = prompt,

        -- Keep cwd as project root so selection.path is relative to the root
        cwd = vim.fn.getcwd(),
        previewer = false,

        -- We tell 'find' exactly which directory to look in
        find_command = find_cmd,

        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                -- Telescope results from 'find_command' usually sit in selection[1]
                local path = selection[1] or selection.path

                -- Populate command line for the final <CR>
                local cmd = string.format(":TermExec cmd='%s'<Left>", path)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), 'n', false)
            end)
            return true
        end,
    })

    builtin.find_files(opts)
end

function M.run_script()
    -- Use "." for current directory
    script_picker("Octopus: Run File", ".")
end

function M.run_script_workspace()
    -- Look specifically in .workspace
    script_picker("Workspace Scripts", ".workspace")
end

return M


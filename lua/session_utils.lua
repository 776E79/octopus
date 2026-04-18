local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local M = {}

-- Save Session Function
M.save_session_as = function()
    builtin.find_files(themes.get_dropdown({
        prompt_title = " Save Session As (CWD) ",
        winblend = 10,
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                local session_name = selection and (selection.path or selection[1]) or action_state.get_current_line()

                actions.close(prompt_bufnr)

                if session_name and session_name ~= "" then
                    if not session_name:match("%.vim$") then
                        session_name = session_name .. ".vim"
                    end

                    vim.schedule(function()
                        if vim.fn.filereadable(session_name) == 1 then
                            local confirm = vim.fn.input("Session exists! Overwrite? (y/n): ")
                            vim.cmd("redraw")
                            if confirm:lower() ~= 'y' then return end
                        end
                        vim.cmd("mksession! " .. vim.fn.fnameescape(session_name))
                        print("Session saved: " .. session_name)
                    end)
                end
            end)
            return true
        end,
    }))
end

-- Load Session Function
M.load_session = function()
    builtin.find_files(themes.get_dropdown({
        prompt_title = " Load Session ",
        winblend = 10,
        previewer = false,
        -- Only show .vim files to avoid clutter
        find_command = { "find", ".", "-name", "*.vim" },
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                if selection then
                    vim.cmd("source " .. vim.fn.fnameescape(selection.path or selection[1]))
                    print("Session loaded: " .. (selection.path or selection[1]))
                end

                -- Optionally, open NvimTree if it's available
                local ok, nvim_tree = pcall(require, "nvim-tree.api")
                if ok then
                    nvim_tree.tree.open()
                    vim.cmd("wincmd p")
                end

            -- Optionally, open NvimTree if it's available
            local ok, nvim_tree = pcall(require, "nvim-tree.api")
            if ok then
                nvim_tree.tree.open()
                vim.cmd("wincmd p")
            end
            end)
            return true
        end,
    }))
end

return M


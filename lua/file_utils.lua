local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local M = {}

M.save_as = function()
    builtin.find_files(themes.get_dropdown({
        prompt_title = " Save File As ",
        winblend = 10,
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            -- This replaces the default action (Enter) specifically for this picker
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                local new_name

                -- If an item is highlighted, use its path; otherwise, use the typed text
                if selection then
                    new_name = selection.path or selection[1]
                else
                    new_name = action_state.get_current_line()
                end

                -- Close the picker BEFORE running the save logic
                actions.close(prompt_bufnr)

                if new_name and new_name ~= "" then
                    vim.schedule(function()
                        -- Check for existence
                        if vim.fn.filereadable(new_name) == 1 then
                            local confirm = vim.fn.input("File exists! Overwrite? (y/n): ")
                            vim.cmd("redraw")
                            if confirm:lower() ~= 'y' then
                                print("Save aborted.")
                                return
                            end
                        end

                        -- Use fnameescape to handle spaces/special chars in filenames
                        vim.cmd("write! " .. vim.fn.fnameescape(new_name))
                        print("Saved as: " .. new_name)
                    end)
                end
            end)

            -- Return true to keep other default mappings (like Esc to close)
            return true
        end,
    }))
end

return M


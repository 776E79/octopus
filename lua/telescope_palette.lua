local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local M = {}

-- Helper function to populate the command line without executing
local function populate_cmd(cmd_text)
    if not cmd_text then return end
    -- \28\14 is <C-\><C-n> to return to normal mode safely
    -- Then we type ':' followed by the command name
    local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>:" .. cmd_text, true, false, true)
    vim.api.nvim_feedkeys(keys, "n", false)
end

M.command_palette = function()
    builtin.commands(themes.get_dropdown({
        winblend = 10,
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                vim.schedule(function()
                    if entry and entry.name then
                        populate_cmd(entry.name)
                    end
                end)
            end)
            return true
        end,
    }))
end

M.command_history = function()
    builtin.command_history(themes.get_dropdown({
        prompt_title = "Command History",
        winblend = 10,
        previewer = false,
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                vim.schedule(function()
                    -- Command history items are usually in entry.value or entry[1]
                    local cmd = entry.value or entry[1]
                    populate_cmd(cmd)
                end)
            end)
            return true
        end,
    }))
end

M.telescope_palette = function()
    builtin.builtin(themes.get_dropdown({
        prompt_title = "Telescope",
        winblend = 10,
        previewer = false,
    }))
end

return M


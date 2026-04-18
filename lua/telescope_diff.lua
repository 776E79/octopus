local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local state   = require('telescope.actions.state')

local M = {}

function M.diff_sequentially(picker_type)
    local first_path = nil
    local function open_picker(step)
        local title = (picker_type == "files" and "Diff File " or "Diff Buffer ") .. step .. "/2"
        local method = (picker_type == "files" and "find_files" or "buffers")

        builtin[method]({
            prompt_title = title,
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local entry = state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if not entry then return end
                    local path = entry.path or (entry.info and entry.info.name) or entry.value

                    if step == 1 then
                        first_path = path
                        vim.schedule(function() open_picker(2) end)
                    else
                        vim.cmd('tabedit ' .. vim.fn.fnameescape(first_path))
                        vim.cmd('vertical diffsplit ' .. vim.fn.fnameescape(path))
                        local n1 = vim.fn.fnamemodify(first_path, ":t")
                        local n2 = vim.fn.fnamemodify(path, ":t")
                        _G.tabutils.set_tab_name(vim.api.nvim_get_current_tabpage(), n1 .. ":" .. n2)
                    end
                end)
                return true
            end,
        })
    end
    open_picker(1)
end

return M


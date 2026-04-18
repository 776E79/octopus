_G.tabutils = {}

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values

local small_ui = {
    layout_strategy = 'center',
    layout_config = {
        width = 0.5,
        height = 0.4,
    },
}

function _G.tabutils.set_tab_name(tab, name)
    vim.api.nvim_tabpage_set_var(tab, "tab_name", name)
    vim.cmd("redrawtabline")
end

function _G.tabutils.get_tab_name(tab)
    -- 1. Check if a manual name exists
    local ok, name = pcall(vim.api.nvim_tabpage_get_var, tab, "tab_name")
    if ok and type(name) == "string" and name ~= "" then
        return name
    end

    -- 2. Auto-detect Plugin Context
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.bo[buf].filetype
        
        if ft == "NeogitStatus" then
            return "Git Status"
        elseif ft == "DiffviewFiles" then
            return "Diffview"
        elseif ft == "term" then
            return "Terminal"
        end
    end

    -- 3. Fallback to first buffer name or "unnamed"
    local cur_win = vim.api.nvim_tabpage_get_win(tab)
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)
    local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(cur_buf), ":t")
    
    return (buf_name ~= "") and buf_name or "unnamed"
end

local function get_tab_list()
    local tabs = vim.api.nvim_list_tabpages()
    local results = {}
    for i, tab in ipairs(tabs) do
        local name = _G.tabutils.get_tab_name(tab)
        table.insert(results, string.format("%d: %s", i, name))
    end
    return results
end

function _G.tabutils.telescope_create()
    pickers.new(small_ui, {
        prompt_title = "New Tab Name",
        finder = finders.new_table { results = get_tab_list() },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local new_name = action_state.get_current_line()
                actions.close(prompt_bufnr)
                vim.cmd('tabnew')
                if new_name and new_name ~= "" then
                    _G.tabutils.set_tab_name(vim.api.nvim_get_current_tabpage(), new_name)
                end
            end)
            return true
        end,
    }):find()
end

function _G.tabutils.list_tabs()
    pickers.new(small_ui, {
        prompt_title = "Switch Tab",
        finder = finders.new_table { results = get_tab_list() },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                    local tab_index = tonumber(selection[1]:match("^(%d+):"))
                    vim.cmd(tab_index .. "tabnext")
                end
            end)
            return true
        end,
    }):find()
end

function _G.tabutils.telescope_rename()
    pickers.new(small_ui, {
        prompt_title = "Rename Current Tab",
        finder = finders.new_table { results = get_tab_list() },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local new_name = action_state.get_current_line()
                actions.close(prompt_bufnr)
                _G.tabutils.set_tab_name(vim.api.nvim_get_current_tabpage(), new_name)
            end)
            return true
        end,
    }):find()
end

function _G.TabLine()
    local s = ""
    local tabs = vim.api.nvim_list_tabpages()
    local current = vim.api.nvim_get_current_tabpage()
    for i, tab in ipairs(tabs) do
        local name = _G.tabutils.get_tab_name(tab)
        local hl = (tab == current) and "%#TabLineSel#" or "%#TabLine#"
        s = s .. hl .. " " .. i .. ":" .. name .. " "
    end
    return s .. "%#TabLineFill#"
end

vim.o.showtabline = 2
vim.o.tabline = "%!v:lua.TabLine()"


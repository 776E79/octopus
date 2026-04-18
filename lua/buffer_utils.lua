local M = {}

--- Helper to handle the actual deletion logic
local function delete_handler(force)
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

    -- If not forcing and the buffer is modified, warn and abort
    if not force and modified then
        vim.api.nvim_echo({{ "No write since last change (use force variant)", "WarningMsg" }}, true, {})
        return
    end

    -- Determine where to go before deleting the buffer
    local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
    if #listed_buffers > 1 then
        vim.cmd("bprevious")
    else
        vim.cmd("enew")
    end

    -- Perform the deletion
    -- Using 'bd!' if force is true, otherwise 'confirm bd'
    local cmd = force and "bd! " or "confirm bd "
    vim.cmd(cmd .. bufnr)
end

function M.smart_delete()
    delete_handler(false)
end

function M.smart_delete_force()
    delete_handler(true)
end

return M


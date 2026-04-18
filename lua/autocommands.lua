local autocmd = vim.api.nvim_create_autocmd

-- File Tree Toggle logic
function _G.toggle_tree()
    if vim.bo.filetype == "NvimTree" then 
        vim.cmd("wincmd p") 
    else 
        vim.cmd("NvimTreeFocus") 
    end
end
vim.keymap.set("n", "<leader>e", _G.toggle_tree)

-- End of file newline enforcement
autocmd("BufWritePre", {
    callback = function()
        local n = vim.api.nvim_buf_line_count(0)
        local last = vim.fn.prevnonblank(n)
        if last <= n then 
            vim.api.nvim_buf_set_lines(0, last, -1, false, {""}) 
        end
    end,
})

-- Session Management
local session_file = vim.fn.getcwd() .. "/.workspace/workspace.nvim"

autocmd("VimEnter", {
    callback = function()
        -- Check if there are no arguments and the session file is readable
        if vim.fn.argc() == 0 and vim.fn.filereadable(session_file) == 1 then
            -- Source the session file to restore session
            vim.cmd("source " .. vim.fn.fnameescape(session_file))

            -- Detect filetype for all buffers, not just visible ones
            local processed_bufs = {}

            -- List all buffers
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(bufnr) and not processed_bufs[bufnr] then
                    -- Switch to the buffer context and trigger filetype detection
                    vim.api.nvim_buf_call(bufnr, function()
                        vim.cmd("filetype detect")
                    end)
                    processed_bufs[bufnr] = true
                end
            end

            -- Optionally, open NvimTree if it's available
            local ok, nvim_tree = pcall(require, "nvim-tree.api")
            if ok then
                nvim_tree.tree.open()
                vim.cmd("wincmd p")
            end
        end
    end,
})

autocmd("VimLeavePre", {
    callback = function()
        -- Ensure .workspace exists before saving
        if vim.fn.isdirectory(".workspace") == 1 then
            local ok, nvim_tree = pcall(require, "nvim-tree.api")
            if ok then nvim_tree.tree.close() end

            vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
        end
    end,
})


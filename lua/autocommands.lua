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
local session_file = vim.fn.getcwd() .. "/.workspace/last_session.vim"

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


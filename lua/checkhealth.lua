local M = {}
M.check = function()
    vim.health.start("Octopus Distribution Health")

    if vim.fn.has("nvim-0.10") == 0 then
        vim.health.error("Octopus requires Neovim 0.10 or higher.")
    else
        vim.health.ok("Neovim version is compatible.")
    end

    local deps = {
        { exe = "rg", name = "ripgrep (Telescope/Grug-far)" },
        { exe = "clangd", name = "clangd (C++ LSP)" },
        { exe = "git", name = "git" },
    }

    for _, dep in ipairs(deps) do
        if vim.fn.executable(dep.exe) == 1 then
            vim.health.ok(dep.name .. " is installed.")
        else
            vim.health.error(dep.name .. " is missing from $PATH.")
        end
    end
end
return M


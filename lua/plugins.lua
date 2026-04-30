local data_dir = vim.fn.stdpath('data') .. '/site'
local plug_path = data_dir .. '/autoload/plug.vim'

if vim.fn.empty(vim.fn.glob(plug_path)) == 1 then
    print("Octopus: Bootstrapping vim-plug...")
    vim.fn.system({'curl', '-fLo', plug_path, '--create-dirs',
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})

    -- Force the runtime path update
    vim.opt.runtimepath:append(data_dir)
    vim.cmd('source ' .. plug_path)
end

-- Use a protected call for plug#begin in case curl failed
local Plug = vim.fn['plug#']
local plugged_path = vim.fn.stdpath('data') .. '/plugged'

vim.call('plug#begin', plugged_path)

Plug 'nvim-lua/plenary.nvim'
Plug 'MagicDuck/grug-far.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'NeogitOrg/neogit'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lukas-reineke/virt-column.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'projekt0n/github-nvim-theme'

-- Unfortunately built in server in nvim 0.12+ is still not powerful enough
-- to replace blink.
Plug 'neovim/nvim-lspconfig'
Plug ('saghen/blink.cmp', { ['tag'] = 'v1.*' })

vim.call('plug#end')


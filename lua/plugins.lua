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

Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-commentary'
Plug 'nvim-lua/plenary.nvim'
Plug 'MagicDuck/grug-far.nvim'
Plug 'williamboman/mason.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })
Plug 'nvim-tree/nvim-tree.lua'
Plug 'szw/vim-maximizer'
Plug 'nvim-telescope/telescope.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'sindrets/diffview.nvim'
Plug('NeogitOrg/neogit')

vim.call('plug#end')


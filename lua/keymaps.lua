local map = vim.keymap.set
local files = require('file_utils')
local palette = require('telescope_palette')
local t_diff = require('telescope_diff')
local runner = require("run_utils")
local buffer_utils = require("buffer_utils")
local session_utils = require('session_utils')

-- Essentials and system
map('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear search highlights' })
map('n', '<leader>q', ':qa<CR>', { desc = 'Quit all' })
map('n', '<leader>QQ', ':qa!<CR>', { desc = 'Force quit all' })
map({'n', 'v'}, '<leader>/', ':Commentary<CR>', { desc = 'Toggle comment' })

-- File operations
map('n', '<leader>s', '<cmd>w<cr>', { desc = 'Save current buffer' })
map('n', '<leader>ss', '<cmd>wa<cr>', { desc = 'save all buffers' })
map('n', '<leader>sa', files.save_as, { desc = 'Save buffer as...' })

-- Splits
map('n', '<leader>vs', ':vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>hs', ':split<CR>', { desc = 'Horizontal split' })
map('n', '<leader>M', ':MaximizerToggle<CR>', { desc = 'Maximize window' })

-- Resizing
map('n', '<leader>h+', ':vertical resize +4<CR>', { desc = 'Increase width' })
map('n', '<leader>h-', ':vertical resize -4<CR>', { desc = 'Decrease width' })
map('n', '<leader>v+', ':resize +4<CR>', { desc = 'Increase height' })
map('n', '<leader>v-', ':resize -4<CR>', { desc = 'Decrease height' })
map('n', '<leader>w=', '<C-w>=', { desc = 'Equally size windows' })

-- Buffers
map('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bp', ':bprev<CR>', { desc = 'Previous buffer' })
map('n', '<leader>bd', buffer_utils.smart_delete, { desc = 'Close current buffer' })
map('n', '<leader>bD', buffer_utils.smart_delete_force, { desc = 'Close current buffer' })
map('n', '<leader>bq', ':q<CR>', { desc = 'Close window/buffer' })
map('n', '<leader>n', '<cmd>enew<cr>', { desc = 'New empty buffer' })

-- Tabs
map('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab' })
map('n', '<leader>tp', ':tabprev<CR>', { desc = 'Previous tab' })
map('n', '<leader>td', ':tabclose<CR>', { desc = 'Close tab' })
map('n', '<leader>tc', function() _G.tabutils.telescope_create() end, { desc = 'Create named tab' })
map('n', '<leader>tl', function() _G.tabutils.list_tabs() end, { desc = 'List/Switch tabs' })
map('n', '<leader>tr', function() _G.tabutils.telescope_rename() end, { desc = 'Rename tab' })

-- Telescope & search tools
map('n', '<leader>:', palette.command_palette, { desc = 'Command palette' })
map('n', '<leader>;', palette.command_history, { desc = 'Command history' })
map('n', '<leader>p', palette.telescope_palette, { desc = 'Telescope palette' })
map('n', '<leader>fl', ':Telescope find_files<CR>', { desc = 'Find files' })
map('n', '<leader>bl', ':Telescope buffers<CR>', { desc = 'List buffers' })
map('n', '<leader>$', ':Telescope live_grep<CR>', { desc = 'Grep in project' })
map('n', '<leader>sr', ':GrugFar<CR>', { desc = 'Search and Replace' })
map('n', '<leader>m', ':Telescope man_pages sections={"1","2","3"}<CR>', { desc = 'Man pages' })

-- LSP & diagnostics
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'List references' })
map('n', 'gh', vim.lsp.buf.hover, { desc = 'Show doc string' })
map('n', '<leader>=', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format buffer' })
map('n', 'K', function() vim.diagnostic.open_float(nil, { focusable = false }) end, { desc = 'Show diagnostics' })
map('n', '<leader>@', ':Telescope lsp_document_symbols<CR>', { desc = 'Document symbols' })
map('n', '<leader>#', ':Telescope lsp_workspace_symbols<CR>', { desc = 'Workspace symbols' })

-- Sequential Diff
map('n', '<leader>db', function() t_diff.diff_sequentially("buffers") end, { desc = 'Diff buffers' })
map('n', '<leader>df', function() t_diff.diff_sequentially("files") end, { desc = 'Diff files' })

-- Neogit
map('n', '<leader>gs', ':Neogit<CR>', { desc = 'Git status (Neogit)' })
map('n', '<leader>gc', ':Neogit commit<CR>', { desc = 'Git commit' })
map('n', '<leader>gp', ':Neogit pull<CR>', { desc = 'Git pull' })
map('n', '<leader>gP', ':Neogit push<CR>', { desc = 'Git push' })
map('n', '<leader>gb', ':Telescope git_branches<CR>', { desc = 'Git branches' })
map('n', '<leader>gl', ':Neogit log<CR>', { desc = 'Git log' })
map('n', '<leader>gd', ':DiffviewOpen HEAD -- %<cr>', { desc = 'Diff current buffer with HEAD' })

-- Script runners
map('n', '<leader>R', runner.run_script, { desc = "Run script" })
map('n', '<leader>RW', runner.run_script_workspace, { desc = "Run workspace script" })

map('n', '<leader>ht', ':split | term<CR>', { desc = 'Horizontal terminal' })
map('n', '<leader>vt', ':vsplit | term<CR>', { desc = 'Vertical terminal' })
map('n', '<leader>Tt', ':tabnew | term<CR>', { desc = 'Tab terminal' })
map('t', '<C-n>', [[<C-\><C-n><C-w>p]], { desc = 'Escape terminal to previous window' })

-- Session control (preserve/load)
map('n', '<leader>SS', session_utils.save_session_as, { desc = "Save Session" })
map('n', '<leader>SL', session_utils.load_session, { desc = "Load Session" })


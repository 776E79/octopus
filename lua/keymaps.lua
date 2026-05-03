local files = require('file_utils')
local palette = require('telescope_palette')
local t_diff = require('telescope_diff')
local buffer_utils = require("buffer_utils")

function toggle_tree()
    if vim.bo.filetype == "NvimTree" then 
        vim.cmd("wincmd p") 
    else 
        vim.cmd("NvimTreeFocus") 
    end
end

-- File operations
vim.keymap.set('n', '<leader>s', '<cmd>w<cr>', { desc = 'Save current buffer' })
vim.keymap.set('n', '<leader>ss', '<cmd>wa<cr>', { desc = 'save all buffers' })
vim.keymap.set('n', '<leader>sa', files.save_as, { desc = 'Save buffer as...' })
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<leader>q', ':qa<CR>', { desc = 'Quit all' })
vim.keymap.set('n', '<leader>QQ', ':qa!<CR>', { desc = 'Force quit all' })
vim.keymap.set('n', '<leader>e', toggle_tree, { desc = 'Toggle file explorer focus' })
vim.keymap.set('n', '<leader>E', ':NvimTreeToggle<CR>', { desc = 'Toggle file' })

-- Splits and windowing
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', { desc = 'Vertical split' })
vim.keymap.set('n', '<leader>hs', ':split<CR>', { desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>M', ':MaximizerToggle<CR>', { desc = 'Maximize window' })
vim.keymap.set('n', '<leader>wn', '<C-w>n', { desc = 'Quickly jump to next window (creates one if none)' })
vim.keymap.set('n', '<leader>wp', '<C-w>p', { desc = 'Quickly jump to prev window (creates one if none)' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Quickly jump to window on the right' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Quickly jump to window on the left' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Quickly jump to window below' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Quickly jump to window above' })

-- Resizing
vim.keymap.set('n', '<leader>h+', ':vertical resize +4<CR>', { desc = 'Increase width' })
vim.keymap.set('n', '<leader>h-', ':vertical resize -4<CR>', { desc = 'Decrease width' })
vim.keymap.set('n', '<leader>v+', ':resize +4<CR>', { desc = 'Increase height' })
vim.keymap.set('n', '<leader>v-', ':resize -4<CR>', { desc = 'Decrease height' })
vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Equally size windows' })

-- Buffers
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', buffer_utils.smart_delete, { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bD', buffer_utils.smart_delete_force, { desc = 'Close current buffer (ignore changes)' })
vim.keymap.set('n', '<leader>bq', ':q<CR>', { desc = 'Close window/buffer' })
vim.keymap.set('n', '<leader>n', '<cmd>enew<cr>', { desc = 'New empty buffer' })

-- Tabs
vim.keymap.set('n', '<leader>tn', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', ':tabprev<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>td', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>tc', function() _G.tabutils.telescope_create() end, { desc = 'Create named tab' })
vim.keymap.set('n', '<leader>tl', function() _G.tabutils.list_tabs() end, { desc = 'List/Switch tabs' })
vim.keymap.set('n', '<leader>tr', function() _G.tabutils.telescope_rename() end, { desc = 'Rename tab' })

-- Telescope & search tools
vim.keymap.set('n', '<leader>:', palette.command_palette, { desc = 'Command palette' })
vim.keymap.set('n', '<leader>;', palette.command_history, { desc = 'Command history' })
vim.keymap.set('n', '<leader>p', palette.telescope_palette, { desc = 'Telescope palette' })
vim.keymap.set('n', '<leader>fl', ':Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>bl', ':Telescope buffers<CR>', { desc = 'List buffers' })
vim.keymap.set('n', '<leader>$', ':Telescope live_grep<CR>', { desc = 'Grep in project' })
vim.keymap.set('n', '<leader>sr', ':GrugFar<CR>', { desc = 'Search and Replace' })
vim.keymap.set('n', '<leader>m', ':Telescope man_pages sections={"1","2","3"}<CR>', { desc = 'Man pages' })

-- LSP & diagnostics
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'List references' })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { desc = 'Show doc string' })
vim.keymap.set('n', 'K', function() vim.diagnostic.open_float(nil, { focusable = false }) end, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>@', ':Telescope lsp_document_symbols<CR>', { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>#', ':Telescope lsp_workspace_symbols<CR>', { desc = 'Workspace symbols' })
vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = "Toggle line comment" })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = "Toggle block comment" })
vim.keymap.set('n', '<leader>qf', '<cmd>copen<cr>', { desc = 'Focus on quickfix window' })
vim.keymap.set('n', '<leader>qk', '<cmd>cclose<cr>', { desc = 'Kill the quickfix window' })
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<cr>', { desc = 'Jump to next fix' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<cr>', { desc = 'Jump to prev fix' })
vim.keymap.set('n', '<leader>mk', '<cmd>silent make | redraw!<cr>', { desc = 'Run make and display output in quickfix window' })
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature help' })

-- Sequential Diff
vim.keymap.set('n', '<leader>db', function() t_diff.diff_sequentially("buffers") end, { desc = 'Diff buffers' })
vim.keymap.set('n', '<leader>df', function() t_diff.diff_sequentially("files") end, { desc = 'Diff files' })

-- Neogit
vim.keymap.set('n', '<leader>Gs', ':Neogit<CR>', { desc = 'Git status (Neogit)' })
vim.keymap.set('n', '<leader>Gc', ':Neogit commit<CR>', { desc = 'Git commit' })
vim.keymap.set('n', '<leader>Gp', ':Neogit pull<CR>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>GP', ':Neogit push<CR>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>Gb', ':Telescope git_branches<CR>', { desc = 'Git branches' })
vim.keymap.set('n', '<leader>Gl', ':Neogit log<CR>', { desc = 'Git log' })
vim.keymap.set('n', '<leader>Gd', ':DiffviewOpen HEAD -- %<cr>', { desc = 'Diff current buffer with HEAD' })

-- Terminal control
vim.keymap.set('n', '<leader>ht', ':split | term<CR>', { desc = 'Horizontal terminal' })
vim.keymap.set('n', '<leader>vt', ':vsplit | term<CR>', { desc = 'Vertical terminal' })
vim.keymap.set('n', '<leader>Tt', ':tabnew | term<CR>', { desc = 'Tab terminal' })
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Escape terminal to previous window' })


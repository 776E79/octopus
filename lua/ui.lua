require('telescope').setup({
  defaults = {
    -- This affects live_grep and other search tools
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",          -- Search hidden files
      "--glob", "!.git/*"  -- But ignore everything inside the .git folder
    },
    initial_mode = 'normal',
  },
  pickers = {
    find_files = {
      hidden = true, 
      find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
    },
  },
})


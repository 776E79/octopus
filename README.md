
A Neovim configuration prioritizing minimalism and intuition.

## Philosophy
The phylosophy is inspired by (aren't we all?) the original UNIX world view:
keep it short, simple, do one thing and do it well. It does not attempt to
do everything under the sun.

What it does:
- Provide intuitive `<leader>`-led commands for:
  - Clean start/quit (and session management - save/load)
      - If `.worspace` folder exists, it will automatically save session
        in `.workspace/.workspace.nvim` upon exit, and will attempt to
        reload it upon start up.
  - File operations (save, save all, save as)
  - Window navigation (splits, maximize/restore, etc)
  - Buffers and tabs (create, list, navigate, rename, delete)
  - Command palette (commands, history)
  - Lists (files, buffers, tabs, search/replace, live grep)
  - Language services: completion, go to defn/decl/help, unfold warnings/errors inline
  - Language services: search symbols globally or in current file
  - Language services: autoformat
  - Diffing (select two buffers or two files to visually diff)
  - Script runners (list scripts/executables and run selected)
  - Embedded terminals
  - Git support (through Neogit)

Most of the UI for listing/selecting/naming/saving is based on Telescope,
giving intuitive visual views. This gives the added benefit of fuzzy
search/match for everything (buffers, tabs, commands, etc).

Prioritizes `<leader>`-based operation, with default leader set to the space bar.
This is quite ergonomic, and does not conflict with any existing shortcuts.

What it does NOT:
- Attempt to do everything under the sun
- Deep support for any particular language
- Implicit integration with any particular tool sets (e.g. build tools).
  Instead, it provides the ability to select scripts to run. Use that
  to run any config/build/deploy/run/debug etc scripts.
- Provide keyboard bindings for every possible function (yes, seriously).
  You can either add your own in `lua/keymaps.lua`, or use the built-in
  `<leader>:` to bring up the command pallete.
- Carry ridiculous amount of plugins most of which make it feel
  like it has ADHD and obsession with apperance.

## Installation
Simply run `install.sh`. You must have neovim already installed.

## Documentation
After installation, simply run `:h octopus`.

## Customization
To customize any of the key bindings, make your changes in `lua/keymaps.lua`.
This is also where the leader is defined (currently set to spacebar).

## Contribution
Simply make pull requests, leave comments, point out issues, or fork and
do with the code whatever you want (just don't sue me)!


local utils = require 'user.utils'
local augroup = utils.augroup
local keymaps = utils.keymaps
-- vim.cmd("set packpath^=~/.config/nvim/plugin/autosession")
-- require '..plugin.autosession'
-- vim.cmd("source ~/.config/nvim/plugin/auto-session/plugin/auto-session.vim")

-- Add some aliases for Neovim Lua API
local o = vim.o
local wo = vim.wo
local g = vim.g
local cmd = vim.cmd

-- TODO --------------------------------------------------------------------------------------------

-- - Flesh out custom colorscheme
--   - Revisit Pmenu highlights:
--   - Experiment with `Diff` highlights to look more like `delta`'s output.
--   - Set `g:terminal_color` values.
--   - Decide on whether I want to include a bunch of language specific highlights
--   - Figure out what to do with `tree-sitter` highlights.
--   - Stretch
--     - Add more highlights for plugins I use, and other popular plugins.
--     - Create monotone variant, where one base color is supplied, and all colors are generate
--       based on transformations of that colors.
-- - Make tweaks to custom status line
--   - Find a way to dynamically display current LSP status/progress/messages.
--   - See if there's an easy way to show show Git sections when in terminal buffer.
--   - Revamp conditions for when segments are displayed
--   - A bunch of other small tweaks.
-- - List searching with telescope.nvim.
--   - Improve workspace folder detection on my telescope.nvim extensions
-- - Other
--   - Figure out how to get Lua LSP to be aware Nvim plugins. Why aren't they on `package.path`?
--   - Play around with `tree-sitter`.
--   - Look into replacing floaterm-vim with vim-toggleterm.lua.






-- Some basic autocommands
if g.vscode == nil then
  augroup { name = 'UserVimBasics', cmds = {
    {{ 'BufEnter', 'FocusGained', 'CursorHold', 'CursorHoldI' }, {
      pattern = '*',
      desc = 'Check if file has changed on disk, if it has and buffer has no changes, reload it.',
      command = 'checktime',
    }},
    { 'BufWritePre' , {
      pattern = '*',
      desc = 'Remove trailing whitespace before write.',
      command = [[%s/\s\+$//e]],
    }},
    { 'TextYankPost', {
      pattern = '*',
      desc = 'Highlight yanked text.',
      callback = function() vim.highlight.on_yank { higroup='Search', timeout=150 } end,
    }},
  }}
end


-- UI ----------------------------------------------------------------------------------------------

-- Set UI related options
o.termguicolors   = true
o.showmode        = false -- don't show -- INSERT -- etc.
wo.colorcolumn    = '100' -- show column boarder
wo.number         = true  -- display numberline
wo.relativenumber = true  -- relative line numbers
wo.signcolumn     = 'yes' -- always have signcolumn open to avoid thing shifting around all the time
o.fillchars       = 'stl: ,stlnc: ,vert:·,eob: ' -- No '~' on lines after end of file, other stuff



-- Terminal ----------------------------------------------------------------------------------------

augroup { name = 'UserNeovimTerm', cmds = {
  { 'TermOpen', {
    pattern = '*',
    desc = 'Set options for terminal buffers.',
    command = 'setlocal nonumber | setlocal norelativenumber | setlocal signcolumn=no',
  }},
}}


require 'user.keymaps'
require 'user.zoom'
require 'user.options'
require 'user.theme'
require 'user.auto-session'

vim.cmd("set noautochdir")

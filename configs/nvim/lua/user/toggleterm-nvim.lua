local utils = require'user.utils'

-- toggleterm.nvim
-- https://github.com/akinsho/toggleterm.nvim
vim.cmd 'packadd toggleterm.nvim'
require'toggleterm'.setup {
  shade_terminals = false,
  float_opts = {
    border = 'curved',
  },
}
utils.augroup { name = 'MaloToggleTermKeymaps', cmds = {
  { 'FileType', {
    pattern = 'toggleterm',
    desc = 'Load floating terminal keymaps.',
    callback = function ()
      utils.keymaps { modes = '', opts = { buffer = true, silent = true }, maps = {
        { '<ESC>', '<Cmd>ToggleTerm<CR>' },
      }}
    end
  }},
}}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<c-s-z>', [[<cmd>lua max_min_term()<CR>]], {silent=true,noremap=true})
end

function _G.max_min_term()
  local winnr = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_height(winnr) > 20 then
    vim.api.nvim_win_set_height(winnr, 20)
  else
    vim.api.nvim_win_set_height(winnr, 1000)
  end
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

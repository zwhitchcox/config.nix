vim.cmd 'packadd auto-session'

local function close_nvim_tree()
  require('nvim-tree.view').close()
end
local function open_nvim_tree()
  require('nvim-tree').open()
end
require("auto-session").setup {
  log_level = "error",

  auto_session_create_enabled = true,
  pre_save_cmds = {close_nvim_tree},
  post_save_cmds = {open_nvim_tree},
  post_open_cmds = {open_nvim_tree},
  post_restore_cmds = {open_nvim_tree},
  auto_session_allowed_dirs = {vim.fn.expand("$HOME")},
  cwd_change_handling = {
    restore_upcoming_session = true,
    pre_cwd_changed_hook = close_nvim_tree,
    post_cwd_changed_hook = open_nvim_tree,
  },
}

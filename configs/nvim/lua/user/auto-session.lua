vim.cmd 'packadd auto-session'

vim.o.sessionoptions="blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal"

require("auto-session").setup {
  log_level = "debug",
  auto_session_create_enabled = true,
  auto_session_enable_file_tree_integration = true,
  cwd_change_handling = {
    restore_upcoming_session = true, -- This is necessary!!
  },
}

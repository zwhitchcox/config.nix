vim.cmd 'packadd auto-session'
vim.cmd 'packadd auto-session-nvim-tree'

vim.o.sessionoptions="blank,buffers,curdir,folds,tabpages,winsize,winpos,terminal"

local auto_session = require("auto-session")
local auto_session_nvim_tree = require('auto-session-nvim-tree')

auto_session.setup {
  log_level = "debug",
  auto_session_create_enabled = true,
  cwd_change_handling = {
    restore_upcoming_session = true, -- This is necessary!!
  },
}

auto_session_nvim_tree.setup(auto_session)

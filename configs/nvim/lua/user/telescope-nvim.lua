-- telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim
vim.cmd 'packadd telescope.nvim'
vim.cmd 'packadd telescope-file-browser.nvim'
vim.cmd 'packadd telescope-fzf-native.nvim'
vim.cmd 'packadd telescope-symbols.nvim'
vim.cmd 'packadd telescope-zoxide'
vim.cmd 'packadd telescope-ui-select.nvim'

local telescope = require 'telescope'
local actions = require 'telescope.actions'
local previewers = require 'telescope.previewers'

telescope.load_extension 'builtin_extensions'
telescope.load_extension 'file_browser'
telescope.load_extension 'fzf'
telescope.load_extension 'zoxide'
telescope.load_extension 'ui-select'


telescope.setup {
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
    path_display = { "smart" },
    color_devicons = true,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    winblend = 10,
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        -- ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        -- ["<C-l>"] = project_actions.change_working_directory,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },
      n = {
        -- ['<CR>'] = actions.select_default + actions.center,
        ['<C-c>'] = actions.close,
        ["<esc>"] = actions.close,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
        s = actions.select_horizontal,
        v = actions.select_vertical,
        t = actions.select_tab,
        j = actions.move_selection_next,
        k = actions.move_selection_previous,
        u = actions.preview_scrolling_up,
        d = actions.preview_scrolling_down,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<C-d>"] = actions.delete_buffer
        },
        n = {
          d = actions.delete_buffer
        }
      }
    }
  },
  extensions = {
    -- file_browser = {
    --   hijack_netrw = true,
    -- },
  },
}


require'telescope._extensions.zoxide.config'.setup {
  mappings = {
    ['<CR>'] = {
      keepinsert = true,
      action = function(selection)
        -- vim.cmd('NvimTreeOpen ' .. selection.path)
        telescope.extensions.file_browser.file_browser { cwb = selection.path }
      end
    },
  },
}

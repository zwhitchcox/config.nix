-- Define all `<Space>` prefixed keymaps with which-key.nvim
-- https://github.com/folke/which-key.nvim
vim.cmd 'packadd which-key.nvim'
vim.cmd 'packadd! gitsigns.nvim' -- needed for some mappings

local wk = require 'which-key'
wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't affect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

-- Spaced prefixed in Normal mode
wk.register ({
  [' '] = {
    name = "+Terminal",
    ['1'] = { "<cmd>1ToggleTerm<cr>", "First Terminal" },
    ['2'] = { "<cmd>2ToggleTerm<cr>", "Second Terminal" },
    ['3'] = { "<cmd>3ToggleTerm<cr>", "Third Terminal" },
    ['4'] = { "<cmd>3ToggleTerm<cr>", "Fourth Terminal" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  -- Windows/splits
    ['-']  = { '<Cmd>new +term<CR>'           , 'New terminal below'               },
    ['_']  = { '<Cmd>botright new +term<CR>'  , 'New termimal below (full-width)'  },
    ['\\'] = { '<Cmd>vnew +term<CR>'          , 'New terminal right'               },
    ['|']  = { '<Cmd>botright vnew +term<CR>' , 'New termimal right (full-height)' },
  },

  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  q = {
    name = "quit",
    q = { "<cmd>q<CR>", "Quit" },
    a = { "<cmd>qa<CR>", "Quit all" },
  },
  Q = {
    name = "quit!",
    q = { "<cmd>q!<CR>", "Quit" },
    a = { "<cmd>qa!<CR>", "Quit all" },
  },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },

  T = {
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
  },

  s = {
    name = "+Session",
    s = { "<cmd>SaveSession<cr>", "Save Session" },
    f = { "<cmd>Autosession search<cr>", "Find Session" },
    -- r = { "<cmd>RestoreSession<cr>", "Restore Current Dir Session" },
    d = { "<cmd>DeleteSession<cr>", "Delete Session" },
  },

  -- Tabs
  t = {
    name = '+Tabs',
    n = { '<Cmd>tabnew +term<CR>'  , 'New with terminal' },
    o = { '<Cmd>tabonly<CR>'       , 'Close all other'   },
    q = { '<Cmd>tabclose<CR>'      , 'Close'             },
    l = { '<Cmd>tabnext<CR>'       , 'Next'              },
    h = { '<Cmd>tabprevious<CR>'   , 'Previous'          },
  },

  w = {
    name = '+Windows',
    -- Split creation
    s = { '<Cmd>split<CR>'  , 'Split below'     },
    v = { '<Cmd>vsplit<CR>' , 'Split right'     },
    q = { '<Cmd>q<CR>'      , 'Close'           },
    o = { '<Cmd>only<CR>'   , 'Close all other' },
    -- Navigation
    k = { '<Cmd>wincmd k<CR>' , 'Go up'           },
    j = { '<Cmd>wincmd j<CR>' , 'Go down'         },
    h = { '<Cmd>wincmd h<CR>' , 'Go left'         },
    l = { '<Cmd>wincmd l<CR>' , 'Go right'        },
    w = { '<Cmd>wincmd w<CR>' , 'Go down/right'   },
    W = { '<Cmd>wincmd W<CR>' , 'Go up/left'      },
    t = { '<Cmd>wincmd t<CR>' , 'Go top-left'     },
    b = { '<Cmd>wincmd b<CR>' , 'Go bottom-right' },
    p = { '<Cmd>wincmd p<CR>' , 'Go to previous'  },
    -- Movement
    K = { '<Cmd>wincmd k<CR>' , 'Move to top'              },
    J = { '<Cmd>wincmd J<CR>' , 'Move to bottom'           },
    H = { '<Cmd>wincmd H<CR>' , 'Move to left'             },
    L = { '<Cmd>wincmd L<CR>' , 'Move to right'            },
    T = { '<Cmd>wincmd T<CR>' , 'Move to new tab'          },
    r = { '<Cmd>wincmd r<CR>' , 'Rotate clockwise'         },
    R = { '<Cmd>wincmd R<CR>' , 'Rotate counter-clockwise' },
    -- Resize
    ['='] = { '<Cmd>wincmd =<CR>'            , 'All equal size'   },
    ['-'] = { '<Cmd>resize -5<CR>'           , 'Decrease height'  },
    ['+'] = { '<Cmd>resize +5<CR>'           , 'Increase height'  },
    ['<'] = { '<Cmd><C-w>5<<CR>'             , 'Decrease width'   },
    ['>'] = { '<Cmd><C-w>5><CR>'             , 'Increase width'   },
    ['|'] = { '<Cmd>vertical resize 106<CR>' , 'Full line-lenght' },
  },

  -- Git
  g = {
    name = '+Git',
    -- vim-fugitive
    b = { '<Cmd>Git blame<CR>' , 'Blame'  },
    s = { '<Cmd>Git<CR>'    , 'Status' },
    d = {
      name = '+Diff',
      s = { '<Cmd>Ghdiffsplit<CR>' , 'Split horizontal' },
      v = { '<Cmd>Gvdiffsplit<CR>' , 'Split vertical'   },
    },
    l = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },

    -- gitsigns.nvim
    h = {
      name = '+Hunks',
      s = { require'gitsigns'.stage_hunk                   , 'Stage'      },
      u = { require'gitsigns'.undo_stage_hunk              , 'Undo stage' },
      r = { require'gitsigns'.reset_hunk                   , 'Reset'      },
      n = { require'gitsigns'.next_hunk                    , 'Go to next' },
      N = { require'gitsigns'.prev_hunk                    , 'Go to prev' },
      p = { require'gitsigns'.preview_hunk                 , 'Preview'    },
      b = { require'gitsigns'.toggle_current_line_blame    , 'Blame'    },
    },
    -- telescope.nvim lists
    T = {
      name = '+Telescope',
      s = { '<Cmd>Telescope git_status<CR>'  , 'Status'         },
      c = { '<Cmd>Telescope git_commits<CR>' , 'Commits'        },
      C = { '<Cmd>Telescope git_commits<CR>' , 'Buffer commits' },
      b = { '<Cmd>Telescope git_branches<CR>' , 'Branches'      },
    },
    -- Other
    v = { '<Cmd>!gh repo view --web<CR>' , 'View on GitHub' },
  },

  -- Language server
  l = {
    name = '+LSP',
    h = { '<Cmd>Lspsaga hover_doc<CR>'   , 'Hover'                   },
    d = { vim.lsp.buf.definition         , 'Jump to definition'      },
    D = { vim.lsp.buf.declaration        , 'Jump to declaration'     },
    a = { '<Cmd>Lspsaga code_action<CR>' , 'Code action'             },
    f = { vim.lsp.buf.formatting         , 'Format'                  },
    r = { '<Cmd>Lspsaga rename<CR>'      , 'Rename'                  },
    t = { vim.lsp.buf.type_definition    , 'Jump to type definition' },
    n = { function() vim.diagnostic.goto_next({float = false}) end, 'Jump to next diagnostic' },
    N = { function() vim.diagnostic.goto_prev({float = false}) end, 'Jump to next diagnostic' },
    T = {
      name = '+Telescope',
      a = { '<Cmd>Telescope lsp_code_actions<CR>'       , 'Code actions'         },
      A = { '<Cmd>Telescope lsp_range_code_actions<CR>' , 'Code actions (range)' },
      r = { '<Cmd>Telescope lsp_references<CR>'         , 'References'           },
      s = { '<Cmd>Telescope lsp_document_symbols<CR>'   , 'Documents symbols'    },
      S = { '<Cmd>Telescope lsp_workspace_symbols<CR>'  , 'Workspace symbols'    },
    },
  },

  -- Seaching with telescope.nvim
  f = {
    name = '+Find',
    b = { '<Cmd>Telescope file_browser<CR>'              , 'File Browser'           },
    f = { '<Cmd>Telescope find_files_workspace<CR>'      , 'Files in workspace'     },
    F = { '<Cmd>Telescope find_files<CR>'                , 'Files in cwd'           },
    e = { "<cmd>NvimTreeFindFile<cr>", "Reveal file in explorer" },
    g = { '<Cmd>Telescope live_grep_workspace<CR>'       , 'Grep in workspace'      },
    G = { '<Cmd>Telescope live_grep<CR>'                 , 'Grep in cwd'            },
    l = { '<Cmd>Telescope current_buffer_fuzzy_find<CR>' , 'Buffer lines'           },
    o = { '<Cmd>Telescope oldfiles<CR>'                  , 'Old files'              },
    t = { '<Cmd>Telescope builtin<CR>'                   , 'Telescope lists'        },
    w = { '<Cmd>Telescope grep_string_workspace<CR>'     , 'Grep word in workspace' },
    W = { '<Cmd>Telescope grep_string<CR>'               , 'Grep word in cwd'       },
    p = { '<Cmd>Telescope project<CR>'                  , 'Project'       },
    v = {
      name = '+Vim',
      a = { '<Cmd>Telescope autocommands<CR>'    , 'Autocommands'    },
      b = { '<Cmd>Telescope buffers<CR>'         , 'Buffers'         },
      c = { '<Cmd>Telescope commands<CR>'        , 'Commands'        },
      C = { '<Cmd>Telescope command_history<CR>' , 'Command history' },
      h = { '<Cmd>Telescope highlights<CR>'      , 'Highlights'      },
      q = { '<Cmd>Telescope quickfix<CR>'        , 'Quickfix list'   },
      l = { '<Cmd>Telescope loclist<CR>'         , 'Location list'   },
      m = { '<Cmd>Telescope keymaps<CR>'         , 'Keymaps'         },
      s = { '<Cmd>Telescope spell_suggest<CR>'   , 'Spell suggest'   },
      o = { '<Cmd>Telescope vim_options<CR>'     , 'Options'         },
      r = { '<Cmd>Telescope registers<CR>'       , 'Registers'       },
      t = { '<Cmd>Telescope filetypes<CR>'       , 'Filetypes'       },
    },
    s = { function() require'telescope.builtin'.symbols(require'telescope.themes'.get_dropdown({sources = {'emoji', 'math'}})) end, 'Symbols' },
    z = { '<Cmd>Telescope zoxide list<CR>', 'Z' },
    ['?'] = { '<Cmd>Telescope help_tags<CR>', 'Vim help' },
  }

}, { prefix = ' ' })

-- Spaced prefiexd in mode Visual mode
wk.register ({
  l = {
    name = '+LSP',
    a = { ':<C-U>Lspsaga range_code_action<CR>' , 'Code action (range)' , mode = 'v' },
  },
}, { prefix = ' ' })


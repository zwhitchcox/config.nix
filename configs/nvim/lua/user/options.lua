local tabstop = 2;
local options = {
  autochdir = false,
  -- Basic Vim Config --------------------------------------------------------------------------------
  scrolloff  = 10,                         -- start scrolling when cursor is within 5 lines of the ledge
  linebreak  = true,                       -- soft wraps on words not individual chars
  mouse      = 'a',                        -- enable mouse support in all modes
  updatetime = 300,                        -- faster completion (4000ms default)
  exrc       = true ,                      -- allow project specific config in .nvimrc or .exrc files
  --
  -- Search and replace
  ignorecase = true,                       -- make searches with lower case characters case insensative
  smartcase  = true,                       -- search is case sensitive only if it contains uppercase chars
  inccommand = 'nosplit',                  -- show preview in buffer while doing find and replace

   --Tab key behavior
  expandtab  = true,                      -- Convert tabs to spaces
  tabstop    = tabstop,                         -- Width of tab character
  shiftwidth = tabstop,                   -- Width of auto-indents

   -- Set where splits open
  splitbelow = true,                       -- open horizontal splits below instead of above which is the default
  splitright = true,                       -- open vertical splits to the right instead of the left with is the default


  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = false,                         -- highlight all matches on previous search pattern
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartindent = true,                      -- make indenting smarter again
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                            -- display lines as one long line
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  breakindent = true,
  breakindentopt = "shift:2,min:40,sbr",
}
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work


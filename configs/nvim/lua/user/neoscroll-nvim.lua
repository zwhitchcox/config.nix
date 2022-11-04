vim.cmd 'packadd neoscroll.nvim'
require('neoscroll').setup({
    easing_function = "quadratic", -- Default easing function
    -- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
    --             '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
    mappings = {'zt', 'zz', 'zb'},
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
-- t['<C-U>'] = {'scroll', {'-vim.wo.scroll', 'true', '80', [['sine']]}}
-- t['<C-D'] = {'scroll', { 'vim.wo.scroll', 'true', '80', [['sine']]}}
-- Use the "circular" easing function
-- t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '500', [['circular']]}}
-- t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '500', [['circular']]}}

-- Use the "circular" easing function
t['K'] = {'scroll', {'-.5', 'true', '80', [['sine']]}}
t['J'] = {'scroll', { '.5', 'true', '80', [['sine']]}}

-- Pass "nil" to disable the easing animation (constant scrolling speed)
t['<C-y>'] = {'scroll', {'-0.10', 'false', '100', nil}}
t['<C-e>'] = {'scroll', { '0.10', 'false', '100', nil}}
-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t['zt']    = {'zt', {'80'}}
t['zz']    = {'zz', {'80'}}
t['zb']    = {'zb', {'80'}}

require('neoscroll.config').set_mappings(t)

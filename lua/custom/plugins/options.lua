-- Personal option/keymap tweaks, auto-loaded by lua/custom/plugins/init.lua.
vim.o.shiftwidth = 2

-- Single <Esc> to exit terminal mode (kickstart default is <Esc><Esc>)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

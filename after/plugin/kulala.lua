local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'mistweaverco/kulala.nvim' }
require('kulala').setup {
  global_keymaps = false,
  global_keymaps_prefix = '<leader>R',
  kulala_keymaps_prefix = '',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'http', 'rest' },
  callback = function(event)
    vim.keymap.set('n', '<leader>Rs', function() require('kulala').run() end, { buffer = event.buf, desc = 'Send request' })
    vim.keymap.set('n', '<leader>Ra', function() require('kulala').run_all() end, { buffer = event.buf, desc = 'Send all requests' })
  end,
})

vim.keymap.set('n', '<leader>Rb', function() require('kulala').scratchpad() end, { desc = 'Open scratchpad' })

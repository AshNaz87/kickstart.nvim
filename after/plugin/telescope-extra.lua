-- telescope.setup() replaces the whole config rather than merging with the
-- call already made in init.lua, so this repeats the extensions config and
-- adds hidden files in find_files.
require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}

vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = 'Find files' })

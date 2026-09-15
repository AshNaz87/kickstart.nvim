local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'stevearc/oil.nvim' }

local detail = false
require('oil').setup {
  keymaps = {
    ['<C-p>'] = false, -- <C-p> is bound globally to Telescope find_files
    ['<C-s>'] = false, -- <C-s> is bound globally to save the current file
    ['gD'] = {
      desc = 'Toggle file detail view',
      callback = function()
        detail = not detail
        if detail then
          require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
        else
          require('oil').set_columns { 'icon' }
        end
      end,
    },
  },
  view_options = {
    show_hidden = true,
  },
}
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

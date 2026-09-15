local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'f-person/git-blame.nvim' }

require('gitblame').setup {
  enabled = true,
  message_template = ' <summary> • <date> • <author> • <<sha>>',
  date_format = '%m-%d-%Y %H:%M:%S',
  virtual_text_column = 1,
}

vim.pack.add {
  gh 'nvim-lua/plenary.nvim',
  gh 'esmuellert/codediff.nvim',
  gh 'm00qek/baleia.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'NeogitOrg/neogit',
}

require('neogit').setup {}

vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'Show Neogit UI' })

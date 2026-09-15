local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'HakonHarnes/img-clip.nvim',
  gh 'brianhuster/live-preview.nvim',
  gh 'mhinz/vim-grepper',
  gh 'github/copilot.vim',
  gh 'akinsho/toggleterm.nvim',
  gh 'zk-org/zk-nvim',
}

require('img-clip').setup {}

vim.keymap.set('n', '<leader>p', '<cmd>PasteImage<cr>', { desc = 'Paste image from system clipboard' })

require('toggleterm').setup {
  autochdir = true,
  auto_scroll = true,
  insert_mappings = false,
  open_mapping = [[<c-\>]],
  persist_mode = true,
  shell = 'zsh',
  size = function(term)
    if term.direction == 'horizontal' then
      return 20
    elseif term.direction == 'vertical' then
      return math.floor(vim.o.columns * 0.4)
    end
  end,
  start_in_insert = true,
}

require('zk').setup {
  picker = 'telescope',
  lsp = {
    config = {
      name = 'zk',
      cmd = { 'zk', 'lsp' },
      filetypes = { 'markdown' },
    },
    auto_attach = {
      enabled = true,
    },
  },
}

local function zk_opts(desc) return { desc = desc, noremap = true, silent = true } end

vim.keymap.set('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", zk_opts 'Create a new note')
vim.keymap.set('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", zk_opts 'Open notes')
vim.keymap.set('n', '<leader>zt', '<Cmd>ZkTags<CR>', zk_opts 'Open notes with tags')
vim.keymap.set(
  'n',
  '<leader>zf',
  "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
  zk_opts 'Search notes matching query'
)
vim.keymap.set('v', '<leader>zf', ":'<,'>ZkMatch<CR>", zk_opts 'Search notes matching selection')

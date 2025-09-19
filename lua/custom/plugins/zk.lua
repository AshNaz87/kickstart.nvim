return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup {
      picker = 'telescope',
      lsp = {
        -- `config` is passed to `vim.lsp.start(config)`
        config = {
          name = 'zk',
          cmd = { 'zk', 'lsp' },
          filetypes = { 'markdown' },
          -- on_attach = ...
          -- etc, see `:h vim.lsp.start()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
        },
      },
    }

    local function addOpts(desc)
      return { desc = desc, noremap = true, silent = true }
    end

    -- Create a new note after asking for its title.
    vim.api.nvim_set_keymap('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", addOpts 'Create a new note')

    -- Open notes.
    vim.api.nvim_set_keymap('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", addOpts 'Open notes')

    -- Open notes associated with the selected tags.
    vim.api.nvim_set_keymap('n', '<leader>zt', '<Cmd>ZkTags<CR>', addOpts 'Open notes with tags')

    -- Search for the notes matching a given query.
    vim.api.nvim_set_keymap(
      'n',
      '<leader>zf',
      "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      addOpts 'Search notes matching query'
    )

    -- Search for the notes matching the current visual selection.
    vim.api.nvim_set_keymap('v', '<leader>zf', ":'<,'>ZkMatch<CR>", addOpts 'Search notes matching selection')
  end,
}

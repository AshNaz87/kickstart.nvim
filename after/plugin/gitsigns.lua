local function gh(repo) return 'https://github.com/' .. repo end

-- gitsigns.setup() replaces the whole config rather than merging with the
-- call already made in init.lua, so this repeats the same `signs` table
-- and adds hunk-navigation/stage/reset keymaps on top.
vim.pack.add { gh 'lewis6991/gitsigns.nvim' }

require('gitsigns').setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  on_attach = function(bufnr)
    local gs = require 'gitsigns'

    -- Navigate between hunks. When in a diff buffer, fall back to the
    -- built-in [c / ]c motions so they keep their normal diff meaning.
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.nav_hunk 'next' end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to next git [C]hange' })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.nav_hunk 'prev' end)
      return '<Ignore>'
    end, { expr = true, buffer = bufnr, desc = 'Jump to previous git [C]hange' })

    -- Stage / reset the hunk under the cursor
    vim.keymap.set('n', '<leader>s', gs.stage_hunk, { buffer = bufnr, desc = 'Git [S]tage hunk' })
    vim.keymap.set('n', '<leader>u', gs.reset_hunk, { buffer = bufnr, desc = 'Git [U]ndo (reset) hunk' })
  end,
}

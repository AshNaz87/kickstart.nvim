return {
  'lewis6991/gitsigns.nvim',
  opts = {
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
  },
}

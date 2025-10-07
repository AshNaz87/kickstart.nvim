return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
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
    end,
  },
}

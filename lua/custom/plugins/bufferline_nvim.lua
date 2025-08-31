return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {}
  end,
  opts = {
    diagnostics_indicator = function(count, level)
      local icon = level:match 'error' and ' ' or ' '

      return ' ' .. icon .. count
    end,
  },
}

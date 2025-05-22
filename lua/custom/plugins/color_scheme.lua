return {
  'EdenEast/nightfox.nvim',
  name = 'nightfox',
  lazy = false,
  priority = 1000,
  config = function()
    require('nightfox').setup {
      palettes = {
        carbonfox = {
          light_grey = '#D3D3D3',
        },
      },
      groups = {
        all = {
          LineNr = { fg = 'palette.light_grey' },
        },
      },
    }

    vim.cmd.colorscheme 'carbonfox'
  end,
}

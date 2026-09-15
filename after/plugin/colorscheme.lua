local function gh(repo) return 'https://github.com/' .. repo end

-- Overrides init.lua's tokyonight-night colorscheme with carbonfox.
-- Loading after init.lua means this call simply wins last; tokyonight
-- stays installed and configured, just unused.
vim.pack.add { gh 'EdenEast/nightfox.nvim' }
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

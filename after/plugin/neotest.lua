local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-neotest/nvim-nio',
  gh 'nvim-neotest/neotest',
  gh 'marilari88/neotest-vitest',
}
require('neotest').setup {
  adapters = { require 'neotest-vitest' },
}

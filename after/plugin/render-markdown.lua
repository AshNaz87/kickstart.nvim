local function gh(repo) return 'https://github.com/' .. repo end

-- Depends on nvim-treesitter and mini.nvim, both already installed by
-- init.lua.
vim.pack.add { gh 'MeanderingProgrammer/render-markdown.nvim' }
require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
  ft = { 'markdown', 'codecompanion' },
  latex = { enabled = false },
}

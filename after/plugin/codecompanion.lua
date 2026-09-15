local function gh(repo) return 'https://github.com/' .. repo end

-- Depends on plenary.nvim and nvim-treesitter, both already installed by
-- init.lua's telescope and treesitter sections.
vim.pack.add { gh 'olimorris/codecompanion.nvim' }

require('codecompanion').setup {
  adapters = {
    acp = {
      claude_code = function() return require('codecompanion.adapters').extend('claude_code', {}) end,
    },
  },
  interactions = {
    chat = {
      adapter = 'claude_code',
    },
    cli = {
      agent = 'claude_code',
      agents = {
        claude_code = {
          cmd = 'claude',
          args = {},
          description = 'Claude Code CLI',
          provider = 'terminal',
        },
      },
    },
  },
  display = {
    chat = {
      window = {
        width = 0.25,
      },
    },
  },
}

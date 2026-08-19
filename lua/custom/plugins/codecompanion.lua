return {
  'olimorris/codecompanion.nvim',
  opts = {
    adapters = {
      acp = {
        claude_code = function()
          return require('codecompanion.adapters').extend('claude_code', {})
        end,
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
  },
  dependencies = {
    {
      'nvim-lua/plenary.nvim',
    },
    'nvim-treesitter/nvim-treesitter',
  },
}

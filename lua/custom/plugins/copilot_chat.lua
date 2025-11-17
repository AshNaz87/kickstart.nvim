return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      auto_insert_mode = true,
    },
    config = function()
      require('CopilotChat').setup {
        highlight_headers = false,
        separator = '---',
        error_header = '> [!ERROR] Error',
      }
    end,
  },
}

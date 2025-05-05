return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    require('lazydev').setup {
      library = {
        'nvim-dap-ui',
      },
    }
  end,
}

return {
  'nvim-java/nvim-java',
  version = '*',
  config = false,
  dependencies = {
    {
      'neovim/nvim-lspconfig',
      opts = {
        servers = {
          jdtls = {},
        },
        setup = {
          jdtls = function()
            require('java').setup {}
          end,
        },
      },
    },
  },
}

return {
  'mason-org/mason-lspconfig.nvim',
  opts = {},
  dependencies = {
    {
      'mason-org/mason.nvim',
      opts = {
        ensure_installed = { 'lua_ls', 'tsserver' },
      },
    },
    'neovim/nvim-lspconfig',
  },
}

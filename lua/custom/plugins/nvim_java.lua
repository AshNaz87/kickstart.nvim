return {
  'nvim-java/nvim-java',
  config = function()
    require('java').setup()

    vim.lsp.config('jdtls', {})

    vim.lsp.enable 'jdtls'
  end,
}

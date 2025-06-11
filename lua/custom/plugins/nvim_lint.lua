return {
  'mfussenegger/nvim-lint',
  event = { 'BufWritePre' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { 'eslint' },
      css = { 'stylelint' },
      scss = { 'stylelint' },
      sass = { 'stylelint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('Lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}

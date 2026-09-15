local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'mfussenegger/nvim-lint' }
local lint = require 'lint'

lint.linters_by_ft = lint.linters_by_ft or {}
lint.linters_by_ft['css'] = { 'stylelint' }
lint.linters_by_ft['html'] = { 'htmlhint' }
lint.linters_by_ft['javascript'] = { 'oxlint' }
lint.linters_by_ft['javascriptreact'] = { 'oxlint' }
lint.linters_by_ft['json'] = { 'jsonlint' }
lint.linters_by_ft['jsonnet'] = { 'jsonnetfmt' }
lint.linters_by_ft['scss'] = { 'stylelint' }
lint.linters_by_ft['terraform'] = { 'tflint' }
lint.linters_by_ft['typescript'] = { 'oxlint' }
lint.linters_by_ft['typescriptreact'] = { 'oxlint' }

if lint.linters.markdownlint then lint.linters.markdownlint.args = { '--config', vim.fn.expand '~/.markdownlint.json', '--stdin' } end

local lint_augroup = vim.api.nvim_create_augroup('Lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function() lint.try_lint() end,
})

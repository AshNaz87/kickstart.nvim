-- conform.setup() replaces the whole config rather than merging with the
-- call already made in init.lua, so this repeats its structure with
-- format-on-save always enabled and web-language formatters added.
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disabled_filetypes = {}
    if disabled_filetypes[vim.bo[bufnr].filetype] then return nil end
    return { timeout_ms = 500 }
  end,
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

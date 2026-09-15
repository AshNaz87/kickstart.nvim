-- Additive LSP server registration: vim.lsp.config()/vim.lsp.enable() merge
-- onto nvim-lspconfig's bundled defaults for this server name rather than
-- replacing init.lua's `servers` table, so this is safe on its own.
vim.lsp.config('eslint', {
  on_new_config = function(config, new_root_dir)
    local function find_node_modules(dir)
      local candidate = dir .. '/node_modules'
      if vim.fn.isdirectory(candidate) == 1 then return candidate end
      local parent = vim.fn.fnamemodify(dir, ':h')
      if parent == dir then return nil end
      return find_node_modules(parent)
    end

    config.settings.nodePath = find_node_modules(new_root_dir)
  end,
})

vim.lsp.enable 'eslint'

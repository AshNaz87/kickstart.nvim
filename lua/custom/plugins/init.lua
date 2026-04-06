-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Iterate over all Lua files in the plugins directory and load them.
-- `vim.fs.dir()` iteration order is unspecified and must not be relied upon.
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end

return {

  -- Personal options, keymaps, environment and diagnostic config.
  -- Using the config directory itself as a "virtual" plugin so lazy.nvim
  -- runs the config function after the rest of init.lua has been sourced.
  {
    dir = vim.fn.stdpath 'config',
    name = 'user-config',
    lazy = false,
    priority = 900,
    config = function()
      -- [[ Options ]]
      vim.o.relativenumber = true
      vim.o.shiftwidth = 2
      vim.o.termguicolors = true

      -- Prepend mise shims to PATH so mason-installed tools are found
      vim.env.PATH = vim.env.HOME .. '/.local/share/mise/shims:' .. vim.env.PATH

      -- [[ Keymaps ]]

      -- Save file from any mode
      vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

      -- Single <Esc> to exit terminal mode (kickstart default is <Esc><Esc>)
      vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      -- Open the diagnostic float for the current line
      vim.keymap.set('n', '<leader>of', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })

      -- LSP hover on K
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = 'LSP: Hover Documentation' })
        end,
      })

      -- Window navigation — same as kickstart but with remap = true so they
      -- still work when a plugin (e.g. nvim-tree) remaps <C-h> etc.
      vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window', remap = true })
      vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window', remap = true })
      vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window', remap = true })
      vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window', remap = true })

      -- [[ Diagnostic config ]]
      -- Overrides the kickstart default with nerd-font icons and richer virtual text.
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_lines = true,
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
    end,
  },

  -- Extend the kickstart telescope spec: show hidden files in find_files.
  -- Works because the kickstart telescope config = function(_, opts) deep-merges opts.
  {
    'nvim-telescope/telescope.nvim',
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
  },
}

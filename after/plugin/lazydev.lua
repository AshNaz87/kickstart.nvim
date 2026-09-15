local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'folke/lazydev.nvim' }
require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- blink.cmp.setup() replaces the whole config rather than merging with the
-- call already made in init.lua, so this repeats it in full with the
-- lazydev source added.
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },

  snippets = { preset = 'luasnip' },

  fuzzy = { implementation = 'lua' },

  signature = { enabled = true },
}

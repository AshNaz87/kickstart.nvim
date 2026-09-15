local function gh(repo) return 'https://github.com/' .. repo end

-- Word motions that stop on subword/punctuation boundaries
vim.pack.add { gh 'chrisgrieser/nvim-spider' }
local function spider_motion(motion)
  return function() require('spider').motion(motion) end
end
vim.keymap.set({ 'n', 'o', 'x' }, 'w', spider_motion 'w', { desc = 'Move to start of next word' })
vim.keymap.set({ 'n', 'o', 'x' }, 'e', spider_motion 'e', { desc = 'Move to end of word' })
vim.keymap.set({ 'n', 'o', 'x' }, 'b', spider_motion 'b', { desc = 'Move to start of previous word' })

-- Surround text objects (ys/cs/ds style)
vim.pack.add { gh 'kylechui/nvim-surround' }

require('nvim-surround').setup {}

-- Treesitter-aware comment strings for embedded languages
vim.pack.add { gh 'folke/ts-comments.nvim' }
if vim.fn.has 'nvim-0.10.0' == 1 then require('ts-comments').setup {} end


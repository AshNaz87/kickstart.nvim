return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      '<C-p>',
      "<CMD>lua require('telescope.builtin').find_files()<CR>",
      desc = 'Find files',
    },
  },
}

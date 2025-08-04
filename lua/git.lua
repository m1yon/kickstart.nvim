return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { 'akinsho/git-conflict.nvim', version = '*', config = true },
  {
    'sindrets/diffview.nvim',
    opts = {
      default_args = {
        DiffviewOpen = { '--imply-local' },
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<leader>gf',
        mode = { 'n', 'x', 'o' },
        '<Cmd>DiffviewFileHistory %<CR>',
        desc = 'View [F]ile history',
      },
      {
        '<leader>gd',
        mode = { 'n', 'x', 'o' },
        '<Cmd>DiffviewOpen<CR>',
        desc = 'View [D]iff view',
      },
    },
  },
}

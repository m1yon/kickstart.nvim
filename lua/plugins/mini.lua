return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      require('mini.files').setup {}

      vim.keymap.set({ 'n', 'x' }, 'm', '<Nop>')
      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'ma', -- Add surrounding in Normal and Visual modes
          delete = 'md', -- Delete surrounding
          find = 'mf', -- Find surrounding (to the right)
          find_left = 'mF', -- Find surrounding (to the left)
          highlight = 'mh', -- Highlight surrounding
          replace = 'mr', -- Replace surrounding
          update_n_lines = 'mn', -- Update `n_lines`
        },
      }

      require('mini.move').setup {
        mappings = {
          -- Move visual selection in Visual mode.
          left = 'H',
          right = 'L',
          down = 'J',
          up = 'K',

          -- Move current line in Normal mode
          line_left = '',
          line_right = '',
          line_down = '',
          line_up = '',
        },
      }

      require('mini.comment').setup {}
    end,
    keys = {
      {
        '<leader>of',
        mode = { 'n' },
        function()
          local miniFiles = require 'mini.files'

          MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
          MiniFiles.reveal_cwd()
        end,
        desc = 'Open Mini [F]iles',
      },
    },
  },
}

return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    lazy = false,
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

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

      require('mini.files').setup()
      require('mini.comment').setup()
      require('mini.starter').setup()
      require('mini.jump2d').setup()
      require('mini.jump').setup()
      require('mini.pick').setup()
      require('mini.extra').setup()

      local starter = require 'mini.starter'
      starter.setup {
        items = {
          starter.sections.recent_files(5, true, true),
          starter.sections.builtin_actions(),
        },
      }
    end,
    keys = {
      {
        '<leader>of',
        mode = { 'n' },
        function()
          local miniFiles = require 'mini.files'

          miniFiles.open(vim.api.nvim_buf_get_name(0), false)
          miniFiles.reveal_cwd()
        end,
        desc = 'Open Mini [F]iles',
      },
      {
        '<leader>ff',
        mode = { 'n' },
        function()
          local miniPick = require 'mini.pick'

          miniPick.builtin.files()
        end,
        desc = 'Find [F]ile',
      },

      {
        '<leader>fg',
        mode = { 'n' },
        function()
          local miniPick = require 'mini.pick'

          miniPick.builtin.grep_live()
        end,
        desc = 'Find [G]rep',
      },

      {
        '<leader>fb',
        mode = { 'n' },
        function()
          local miniPick = require 'mini.pick'

          miniPick.builtin.buffers()
        end,
        desc = 'Find [B]uffer',
      },

      {
        '<leader>fh',
        mode = { 'n' },
        function()
          local miniPick = require 'mini.pick'

          miniPick.builtin.help()
        end,
        desc = 'Find [H]elp',
      },

      {
        '<leader>f;',
        mode = { 'n' },
        function()
          local miniPick = require 'mini.pick'
          miniPick.builtin.resume()
        end,
        desc = '[R]esume Find',
      },

      {
        '<leader>fr',
        mode = { 'n' },
        function()
          local miniExtra = require 'mini.extra'
          miniExtra.pickers.lsp { scope = 'references' }
        end,
        desc = 'Find [R]eferences',
      },

      {
        '<leader>fi',
        mode = { 'n' },
        function()
          local miniExtra = require 'mini.extra'
          miniExtra.pickers.lsp { scope = 'implementation' }
        end,
        desc = 'Find [I]mplementations',
      },
    },
  },
}

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
      require('mini.git').setup()
      require('mini.diff').setup()
      require('mini.comment').setup()
      require('mini.starter').setup()
      require('mini.jump2d').setup()
      require('mini.jump').setup()
      require('mini.pick').setup()
      require('mini.extra').setup()
      require('mini.cursorword').setup()
      require('mini.visits').setup()
      require('mini.icons').setup()
      require('mini.statusline').setup()
      require('mini.pairs').setup()
      require('mini.notify').setup()

      local indentscope = require 'mini.indentscope'
      indentscope.setup {
        draw = {
          delay = 0,
          animation = indentscope.gen_animation.none(),
        },
      }

      local clue = require 'mini.clue'
      require('mini.clue').setup {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        window = {
          delay = 0,
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
          { mode = 'n', keys = '<Leader>f', desc = '+Find' },
          { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
          { mode = 'n', keys = '<Leader>g', desc = '+Git' },
          { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
        },
      }

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

      {
        '<leader>fd',
        mode = { 'n' },
        function()
          local miniExtra = require 'mini.extra'
          miniExtra.pickers.diagnostic()
        end,
        desc = 'Find [D]iagnostics',
      },

      {
        '<leader>vr',
        mode = { 'n' },
        function()
          local miniExtra = require 'mini.extra'
          miniExtra.pickers.visit_paths()
        end,
        desc = '[R]ecent Visits',
      },

      {
        '<leader>vl',
        mode = { 'n' },
        function()
          local miniExtra = require 'mini.extra'
          miniExtra.pickers.visit_labels()
        end,
        desc = 'Visit [L]abels',
      },

      {
        '<leader>va',
        mode = { 'n' },
        function()
          local miniVisits = require 'mini.visits'
          miniVisits.add_label()
        end,
        desc = '[A]dd Label',
      },
    },
  },
}

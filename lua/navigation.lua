vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half scroll [D]own and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half scroll [U]p and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Search forward and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Search back and center' })
vim.keymap.set('n', '<C-w>', '<cmd>tabclose<cr>', { desc = 'Search back and center' })

-- disable mouse mode
vim.o.mouse = ''

local autocmd = vim.api.nvim_create_autocmd
-- relative numbers by default, absolute line numbers in command mode
local autocmd_group = vim.api.nvim_create_augroup('MyDots', { clear = true })
autocmd({ 'CmdlineEnter' }, {
  group = autocmd_group,
  callback = function()
    vim.opt.relativenumber = false
    vim.cmd.redraw()
  end,
})
autocmd({ 'CmdlineLeave' }, {
  group = autocmd_group,
  callback = function()
    vim.opt.relativenumber = true
    vim.cmd.redraw()
  end,
})

return {
  {
    'otavioschwanck/arrow.nvim',
    dependencies = {
      { 'echasnovski/mini.icons' },
    },
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = '<C-;>', -- Per Buffer Mappings
    },
  },

  {
    'jinh0/eyeliner.nvim',
    config = function()
      require('eyeliner').setup {
        -- show highlights only after keypress
        highlight_on_key = true,

        -- dim all other characters if set to true (recommended!)
        dim = false,

        -- set the maximum number of characters eyeliner.nvim will check from
        -- your current cursor position; this is useful if you are dealing with
        -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
        max_length = 9999,

        -- filetypes for which eyeliner should be disabled;
        -- e.g., to disable on help files:
        -- disabled_filetypes = {"help"}
        disabled_filetypes = {},

        -- buftypes for which eyeliner should be disabled
        -- e.g., disabled_buftypes = {"nofile"}
        disabled_buftypes = {},

        -- add eyeliner to f/F/t/T keymaps;
        -- see section on advanced configuration for more information
        default_keymaps = true,
      }

      vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bg = '#ff0077', fg = '#ffffff', bold = true, underline = false })
      vim.api.nvim_set_hl(0, 'EyelinerSecondary', { bg = '#96b4ff', fg = '#000000', bold = true })

      vim.keymap.set({ 'n', 'v' }, '<Right>', ';', { desc = 'Repeat char search forward' })
      vim.keymap.set({ 'n', 'v' }, '<Left>', ',', { desc = 'Repeat char search backward' })
    end,
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
}

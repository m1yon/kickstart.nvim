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

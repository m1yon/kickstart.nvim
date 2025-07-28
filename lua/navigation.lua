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
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    config = function()
      require('flash').setup {
        modes = { search = { enabled = true } },
      }

      vim.api.nvim_set_hl(0, 'FlashBackdrop', { fg = '#555566' })

      vim.api.nvim_set_hl(0, 'FlashMatch', {
        fg = '#22d3ee',
        bold = true,
        nocombine = true,
      })

      vim.api.nvim_set_hl(0, 'FlashCurrent', {
        fg = '#a3e635',
        bold = true,
        nocombine = true,
      })

      vim.api.nvim_set_hl(0, 'FlashLabel', {
        fg = '#ffffff',
        bg = '#ff0077',
        bold = true,
        nocombine = true,
      })

      vim.api.nvim_set_hl(0, 'FlashPrompt', { fg = '#f0f0f0' })
      vim.api.nvim_set_hl(0, 'FlashPromptIcon', { fg = '#ff0077' })
      vim.api.nvim_set_hl(0, 'FlashCursor', { bg = '#ff8800' })
    end,
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },
}

vim.keymap.set('n', '<S-h>', ':tabprevious<CR>', { desc = 'Move to left tab' })
vim.keymap.set('n', '<S-l>', ':tabnext<CR>', { desc = 'Move to right tab' })
vim.keymap.set('n', '<C-w>', ':tabclose<CR>', { desc = 'Close current tab' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half scroll [D]own and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half scroll [U]p and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Search forward and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Search back and center' })

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
      { 'nvim-tree/nvim-web-devicons' },
      -- or if using `mini.icons`
      -- { "echasnovski/mini.icons" },
    },
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
  },

  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup()

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },
}

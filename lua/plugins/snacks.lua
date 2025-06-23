return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      animate = { enabled = false },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      words = { enabled = true },
      lazygit = { enabled = true },
    },
    keys = {
      {
        '<leader>gl',
        function()
          local file = vim.trim(vim.api.nvim_buf_get_name(0))
          Snacks.lazygit.open { cwd = vim.fn.fnamemodify(file, ':h') }
        end,
        desc = 'Open [L]azygit',
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'View [F]ile history',
      },
    },
  },
}

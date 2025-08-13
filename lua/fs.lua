return {

  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
      { 'folke/snacks.nvim', lazy = true },
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>yf',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open [Y]azi at the current [F]ile',
      },
      {
        -- Open in the current working directory
        '<leader>yd',
        '<cmd>Yazi cwd<cr>',
        desc = "Open [Y]azi in nvim's working [D]irectory",
      },
      {
        '<leader>yR',
        '<cmd>Yazi toggle<cr>',
        desc = '[R]esume the last [Y]azi session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
      integrations = {
        grep_in_directory = 'snacks.picker',
        grep_in_selected_files = 'snacks.picker',
        picker_add_copy_relative_path_action = 'snacks.picker',
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    keys = {
      {
        '<leader>yo',
        '<cmd>Oil<cr>',
        desc = 'Open [O]il',
      },
    },
  },
}

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      lazygit = { enabled = true },
    },
    keys = {
      {
        '<leader>go',
        function()
          local file = vim.trim(vim.api.nvim_buf_get_name(0))
          Snacks.lazygit.open { cwd = vim.fn.fnamemodify(file, ':h') }
        end,
        desc = '[O]pen lazygit',
      },
    },
  },
}

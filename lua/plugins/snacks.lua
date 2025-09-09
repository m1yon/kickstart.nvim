return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = false,
      },
      indent = { enabled = true, animate = { enabled = false } },
      input = { enabled = true },
      picker = {
        enabled = false,
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      words = { enabled = true },
      git = { enabled = false },
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
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.inlay_hints():map '<leader>uh'
        end,
      })
    end,
  },
}

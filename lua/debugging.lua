return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      {
        '<leader>dh',
        mode = { 'n' },
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>dl',
        mode = { 'n' },
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dk',
        mode = { 'n' },
        function()
          require('dap').restart_frame()
        end,
        desc = 'Restart Frame',
      },
      {
        '<leader>dj',
        mode = { 'n' },
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dc',
        mode = { 'n' },
        function(opts)
          require('dap').continue(opts)
        end,
        desc = '[C]ontinue',
      },
      {
        '<leader>db',
        mode = { 'n' },
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle [B]reakpoint',
      },
    },
  },
  {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup()
    end,
    keys = {
      {
        '<leader>dt',
        mode = { 'n' },
        function()
          require('dap-go').debug_test()
        end,
        desc = 'Debug [T]est under cursor',
      },
      {
        '<leader>da',
        mode = { 'n' },
        function()
          require('dap-go').debug_last_test()
        end,
        desc = 'Debug last test [A]gian',
      },
    },
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()
    end,
    keys = {
      {
        '<leader>du',
        mode = { 'n' },
        function()
          require('dapui').toggle()
        end,
        desc = 'Toggle debug [U]I',
      },
    },
  },
}

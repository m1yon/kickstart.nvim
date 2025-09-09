vim.opt.tabstop = 2

return {
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
              'WinEnter',
              'BufEnter',
              'BufWritePost',
              'SessionLoadPost',
              'FileChangedShellPost',
              'VimResized',
              'Filetype',
              'CursorMoved',
              'CursorMovedI',
              'ModeChanged',
            },
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', file_status = true, path = 1 } },
          lualine_x = {
            'lsp_status',
            function()
              local status, conform = pcall(require, 'conform')
              if not status then
                return 'Conform not installed'
              end

              local lsp_format = require 'conform.lsp_format'

              -- Get formatters for the current buffer
              local formatters = conform.list_formatters_for_buffer()
              if formatters and #formatters > 0 then
                local formatterNames = {}

                for _, formatter in ipairs(formatters) do
                  table.insert(formatterNames, formatter)
                end

                return '󰷈 ' .. table.concat(formatterNames, ' ')
              end

              -- Check if there's an LSP formatter
              local bufnr = vim.api.nvim_get_current_buf()
              local lsp_clients = lsp_format.get_format_clients { bufnr = bufnr }

              if not vim.tbl_isempty(lsp_clients) then
                return '󰷈 LSP Formatter'
              end

              return ''
            end,
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-dap-ui', 'mason', 'fzf', 'lazy', 'fugitive' },
      }
    end,
  },

  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup {
        -- Style preset for diagnostic messages
        -- Available options:
        -- "modern", "classic", "minimal", "powerline",
        -- "ghost", "simple", "nonerdfont", "amongus"
        preset = 'modern',

        transparent_bg = false, -- Set the background of the diagnostic to transparent
        transparent_cursorline = false, -- Set the background of the cursorline to transparent (only one the first diagnostic)

        hi = {
          error = 'DiagnosticError', -- Highlight group for error messages
          warn = 'DiagnosticWarn', -- Highlight group for warning messages
          info = 'DiagnosticInfo', -- Highlight group for informational messages
          hint = 'DiagnosticHint', -- Highlight group for hint or suggestion messages
          arrow = 'NonText', -- Highlight group for diagnostic arrows

          -- Background color for diagnostics
          -- Can be a highlight group or a hexadecimal color (#RRGGBB)
          background = 'CursorLine',

          -- Color blending option for the diagnostic background
          -- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
          mixing_color = 'None',
        },

        options = {
          -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
          show_source = {
            enabled = true,
            if_many = false,
          },

          -- Use icons defined in the diagnostic configuration
          use_icons_from_diagnostic = false,

          -- Set the arrow icon to the same color as the first diagnostic severity
          set_arrow_to_diag_color = false,

          -- Add messages to diagnostics when multiline diagnostics are enabled
          -- If set to false, only signs will be displayed
          add_messages = true,

          -- Time (in milliseconds) to throttle updates while moving the cursor
          -- Increase this value for better performance if your computer is slow
          -- or set to 0 for immediate updates and better visual
          throttle = 20,

          -- Minimum message length before wrapping to a new line
          softwrap = 30,

          -- Configuration for multiline diagnostics
          -- Can either be a boolean or a table with the following options:
          --  multilines = {
          --      enabled = false,
          --      always_show = false,
          -- }
          -- If it set as true, it will enable the feature with this options:
          --  multilines = {
          --      enabled = true,
          --      always_show = false,
          -- }
          multilines = {
            -- Enable multiline diagnostic messages
            enabled = false,

            -- Always show messages on all lines for multiline diagnostics
            always_show = false,

            -- Trim whitespaces from the start/end of each line
            trim_whitespaces = false,

            -- Replace tabs with spaces in multiline diagnostics
            tabstop = 4,
          },

          -- Display all diagnostic messages on the cursor line
          show_all_diags_on_cursorline = true,

          -- Enable diagnostics in Insert mode
          -- If enabled, it is better to set the `throttle` option to 0 to avoid visual artifacts
          enable_on_insert = false,

          -- Enable diagnostics in Select mode (e.g when auto inserting with Blink)
          enable_on_select = false,

          overflow = {
            -- Manage how diagnostic messages handle overflow
            -- Options:
            -- "wrap" - Split long messages into multiple lines
            -- "none" - Do not truncate messages
            -- "oneline" - Keep the message on a single line, even if it's long
            mode = 'wrap',

            -- Trigger wrapping to occur this many characters earlier when mode == "wrap".
            -- Increase this value appropriately if you notice that the last few characters
            -- of wrapped diagnostics are sometimes obscured.
            padding = 0,
          },

          -- Configuration for breaking long messages into separate lines
          break_line = {
            -- Enable the feature to break messages after a specific length
            enabled = false,

            -- Number of characters after which to break the line
            after = 30,
          },

          -- Custom format function for diagnostic messages
          -- Example:
          -- format = function(diagnostic)
          --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
          -- end
          format = nil,

          virt_texts = {
            -- Priority for virtual text display
            priority = 2048,
          },

          -- Filter diagnostics by severity
          -- Available severities:
          -- vim.diagnostic.severity.ERROR
          -- vim.diagnostic.severity.WARN
          -- vim.diagnostic.severity.INFO
          -- vim.diagnostic.severity.HINT
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },

          -- Events to attach diagnostics to buffers
          -- You should not change this unless the plugin does not work with your configuration
          overwrite_events = nil,
        },
        disabled_ft = {}, -- List of filetypes to disable the plugin
      }

      vim.diagnostic.config { virtual_text = false } -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
  },
}

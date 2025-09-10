-- Leader key =================================================================
vim.g.mapleader = ' '

-- General ====================================================================
vim.o.backup       = false          -- Don't store backup
vim.o.mouse        = ''             -- Disable mouse
vim.o.mousescroll  = 'ver:25,hor:6' -- Customize mouse scroll
vim.o.switchbuf    = 'usetab'       -- Use already opened buffers when switching
vim.o.writebackup  = false          -- Don't store backup (better performance)
vim.o.undofile     = true           -- Enable persistent undo

vim.o.shada        = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file

vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- Editing ====================================================================
vim.o.autoindent    = true     -- Use auto indent
vim.o.expandtab     = true     -- Convert tabs to spaces
vim.o.formatoptions = 'rqnl1j' -- Improve comment editing
vim.o.ignorecase    = true     -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch     = true     -- Show search results while typing
vim.o.infercase     = true     -- Infer letter cases for a richer built-in keyword completion
vim.o.shiftwidth    = 2        -- Use this number of spaces for indentation
vim.o.smartcase     = true     -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent   = true     -- Make indenting smart
vim.o.tabstop       = 2        -- Insert 2 spaces for a tab
vim.o.virtualedit   = 'block'  -- Allow going past the end of line in visual block mode
vim.o.relativenumber = true   -- Use relative line numbers

vim.o.iskeyword     = '@,48-57,_,192-255,-' -- Treat dash separated words as a word text object

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list
-- item'
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.completeopt = 'menuone,noselect' -- Show popup even with one item and don't autoselect first
if vim.fn.has('nvim-0.11') == 1 then
  vim.o.completeopt = 'menuone,noselect,fuzzy,nosort' -- Use fuzzy matching for built-in completion
end
vim.o.complete     = '.,w,b,kspell' -- Use spell check and don't use tags for completion

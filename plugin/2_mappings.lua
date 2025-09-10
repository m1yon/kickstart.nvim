-- Leader mappings ============================================================
-- stylua: ignore start

-- Create global tables with information about clue groups in certain modes
-- Structure of tables is taken to be compatible with 'mini.clue'.
_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'n', keys = '<Leader>L', desc = '+Lua/Log' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>r', desc = '+R' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal/Minitest' },
  { mode = 'n', keys = '<Leader>T', desc = '+Test' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },

  { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'x', keys = '<Leader>r', desc = '+R' },
}

-- Create `<Leader>` mappings
local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

-- b is for 'buffer'
nmap_leader('ba', '<Cmd>b#<CR>',                                 'Alternate')
nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>',         'Delete')
nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>',  'Delete!')
nmap_leader('bs', '<Cmd>lua Config.new_scratch_buffer()<CR>',    'Scratch')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- e is for 'explore' and 'edit'
local edit_config_file = function(filename)
  return '<Cmd>edit ' .. vim.fn.stdpath('config') .. '/plugin/' .. filename .. '<CR>'
end
nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>',                             'Directory')
nmap_leader('ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'File directory')
nmap_leader('em', edit_config_file('20_mini.lua'),                             'Mini.nvim config')
nmap_leader('eo', edit_config_file('10_options.lua'),                          'Options config')
nmap_leader('ep', edit_config_file('21_plugins.lua'),                          'Plugins config')
nmap_leader('es', '<Cmd>lua MiniSessions.select()<CR>',                        'Sessions')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>',                     'Quickfix')

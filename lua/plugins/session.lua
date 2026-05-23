return {
  'rmagatti/auto-session',
  dependencies = {
    'nvim-neo-tree/neo-tree.nvim',
  },
  opts = {
    suppressed_dirs = { '~', '/' },  -- don't save sessions for home/root
    pre_save_cmds = { 'Neotree close' },
    post_restore_cmds = { 'Neotree show' },
  },
}

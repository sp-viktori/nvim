return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    notifier = { enabled = true },
  },
  keys = {
    {
      '<leader>m',
      function() Snacks.notifier.show_history() end,
      desc = 'Notification history',
    },
  },
}

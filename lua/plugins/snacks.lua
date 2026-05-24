return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = {
      enabled = true,
      top_down = false,
      timeout = 10000,
    },
  },
  keys = {
    {
      "<leader>m",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification history",
    },
  },
}

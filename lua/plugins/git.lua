return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    -- "esmuellert/codediff.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Neogit",
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open()
      end,
      desc = "Neogit status",
    },
    {
      "<leader>gc",
      function()
        require("neogit").open({ "commit" })
      end,
      desc = "Neogit commit",
    },
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
  },
  opts = {
    integrations = { diffview = true },
    treesitter_diff_highlight = true,
    kind = "split",
    graph_style = "unicode",
  },
  config = function(_, opts)
    require("neogit").setup(opts)
    vim.api.nvim_set_hl(0, "NeogitPopupSwitchEnabled", { fg = "#cf222e", bold = true })
    vim.api.nvim_set_hl(0, "NeogitPopupOptionEnabled", { fg = "#cf222e", bold = true })

    -- the color is from github light default, taken from "NeogitPopupSwitchKey"
    -- this instead links the two, as an alternative/more theme compatible version (untested):
    -- vim.api.nvim_set_hl(0, "NeogitPopupSwitchEnabled", { link = "NeogitPopupSwitchKey" })
  end,
}

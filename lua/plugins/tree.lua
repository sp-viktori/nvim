return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      filesystem = {
        follow_current_file = { enabled = true },
      },
      window = {
        position = "right",
      },
    })
    vim.api.nvim_create_autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "neo-tree" then
          vim.opt_local.fillchars:append({ eob = " " })
        end
      end,
    })
  end,
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
    { "<leader>o", "<cmd>Neotree reveal<cr>", desc = "Reveal current file in tree" },
  },
}

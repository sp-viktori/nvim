return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "ayu-theme/ayu-vim",
    name = "ayu",
    priority = 1000,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme("github_light_default")
    end,
  },
}

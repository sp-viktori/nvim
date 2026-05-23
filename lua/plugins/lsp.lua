return {
  {
    'williamboman/mason.nvim',
    opts = {},
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = { 'basedpyright' },  -- auto-install on first run
      automatic_installation = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable({ 'basedpyright' })
      vim.lsp.config('basedpyright', {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'standard', -- 'off' | 'basic' | 'standard' | 'strict' | 'all'
            },
          },
        },
      })
    end,
  },
}

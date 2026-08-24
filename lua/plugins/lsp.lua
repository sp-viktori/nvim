return {
  {
    'williamboman/mason.nvim',
    -- Put Mason's bin at the END of PATH so project-local tools (e.g. an
    -- activated venv's ruff/black) win, with Mason as the fallback.
    opts = { PATH = 'append' },
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

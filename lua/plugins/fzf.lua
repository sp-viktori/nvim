return {
  'ibhagwan/fzf-lua',
  opts = { fzf_colors = true },
  keys = {
    { '<C-p>', function() require('fzf-lua').files() end, desc = 'Fuzzy file search' },
    { '<leader><leader>', function() require('fzf-lua').buffers() end, desc = 'Fuzzy buffer search' },
    {
      '<leader>F',
      function()
        local exclude = {
          '.Trash',
          '.cache',
          '.cursor/extensions',
          '.git',
          '.local',
          '.pyenv',
          '.secret',
          '.vscode/extensions',
          'Applications',
          'Library',
        }
        local exclude_flags = table.concat(
          vim.tbl_map(function(d) return '--exclude ' .. d end, exclude),
          ' '
        )
        require('fzf-lua').files({
          cwd = '~',
          fd_opts = '--color=never --type f --hidden --follow ' .. exclude_flags,
        })
      end,
      desc = 'Fuzzy search from ~',
    },
  }
}

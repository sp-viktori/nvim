return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      "<leader>tf",
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.notify("Format on save (buffer): " .. (vim.b.disable_autoformat and "off" or "on"))
      end,
      desc = "Toggle format on save (buffer)",
    },
    {
      "<leader>tF",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("Format on save (global): " .. (vim.g.disable_autoformat and "off" or "on"))
      end,
      desc = "Toggle format on save (global)",
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = function(bufnr)
        local root = vim.fs.root(bufnr, { "pyproject.toml", "setup.cfg", "setup.py" })
        if root then
          local f = io.open(root .. "/pyproject.toml", "r")
          if f then
            local content = f:read("*a")
            f:close()
            if content:find("%[tool%.ruff") then
              return { "ruff_fix", "ruff_format" }
            end
          end
        end
        return { "isort", "black" }
      end,
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}

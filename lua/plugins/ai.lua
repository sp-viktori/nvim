return {
  {
    "ggml-org/llama.vim",

    init = function()
      vim.g.llama_config = {
        show_info = 1, -- set to 2 to add more debug info
      }

      -- llama.vim highlight overrides, tuned for github_light
      local function set_llama_hl()
        -- ghost-text suggestion: soft gray, italic so it reads as "not real yet"
        vim.api.nvim_set_hl(0, "llama_hl_fim_hint", { fg = "#8c959f", italic = true })
        -- inline perf stats: lighter gray (tweak to taste)
        vim.api.nvim_set_hl(0, "llama_hl_fim_info", { fg = "#afb8c1" })
        -- selected block for instruction editing: link to your theme's Visual
        vim.api.nvim_set_hl(0, "llama_hl_inst_src", { link = "Visual" })
        -- instruction virtual-text status markers
        vim.api.nvim_set_hl(0, "llama_hl_inst_virt_proc", { fg = "#8c959f" })
        vim.api.nvim_set_hl(0, "llama_hl_inst_virt_gen", { fg = "#8c959f" })
        vim.api.nvim_set_hl(0, "llama_hl_inst_virt_ready", { fg = "#0969da" })
      end

      -- re-apply whenever the colorscheme loads/changes, so it isn't clobbered
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("LlamaColors", { clear = true }),
        callback = set_llama_hl,
      })

      -- apply once now for the already-loaded scheme
      set_llama_hl()
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
          ["llama.cpp"] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://127.0.0.1:8012", -- same server llama.vim uses
                api_key = "TERM", -- any non-empty string; no real auth
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "qwen3-coder-30b", -- just a label, can be anything
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = { adapter = "llama.cpp" },
        inline = { adapter = "llama.cpp" },
        cmd = { adapter = "llama.cpp" },
      },
    },
    init = function()
      vim.keymap.set({ "n", "v" }, "<leader>cc", ":CodeCompanionChat Toggle<CR>", { desc = "CodeCompanion chat" })
      vim.keymap.set("v", "<leader>ca", ":CodeCompanionActions<CR>", { desc = "CodeCompanion actions" })
    end,
  },
}

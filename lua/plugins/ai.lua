return {
  -- ==========================================
  -- 1. LOCAL GHOST TEXT (RTX 4060 Ti)
  -- ==========================================
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('minuet').setup({
        provider = 'openai',
        provider_options = {
          openai = {
            model = 'qwen2.5-coder:7b', -- Fast local model
            end_point = 'http://localhost:11434/v1/chat/completions',
            api_key = 'TERM',
            stream = true,
            template = { model_type = 'qwen' },
            optional = {
              stop = { "<|endoftext|>", "<|file_separator|>", "\n\n" },
              max_tokens = 128,
            }
          },
        },
        virtualtext = {
          auto_trigger_ft = { "python", "rust", "c", "cpp", "go", "lua" },
          keymap = {
            accept = "<C-g>",
            accept_line = "<A-a>",
            dismiss = "<A-e>",
            next = "<A-]>",
            prev = "<A-[>",
          },
        },
      })
    end,
  },

  -- ==========================================
  -- 2. SMART CHAT & FIX (OpenRouter Fix)
  -- ==========================================
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- Define the OpenRouter adapter manually to avoid the "nil" lookup error
      local openrouter_adapter = require("codecompanion.adapters").extend("openai", {
        url = "https://openrouter.ai/api/v1/chat/completions",
        env = {
          api_key = "MY_API_KEY", -- not giveing you UwU..
        },
        headers = {
          ["HTTP-Referer"] = "https://github.com/olimorris/codecompanion.nvim",
          ["X-Title"] = "Suhas-Nvim",
        },
        schema = {
          model = {
            default = "qwen/qwen3-vl-30b-a3b-thinking",
          },
          -- IMPORTANT: stream = false fixes the "choices nil" error 
          -- that occurs when thinking models send reasoning tokens.
          stream = { default = false },
        },
      })

      require("codecompanion").setup({
        strategies = {
          chat = { adapter = openrouter_adapter },
          inline = { adapter = openrouter_adapter },
        },
        adapters = {
          openrouter = openrouter_adapter,
        },
      })

      -- KEYBINDS
      local map = vim.keymap.set
      map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI Chat" })
      map("n", "<leader>af", "<cmd>CodeCompanion Fix any typos or logic errors in #buffer<cr>", { desc = "AI Fix Line" })
      map("v", "<leader>af", "<cmd>CodeCompanion Fix the selected code using #buffer as context<cr>", { desc = "AI Fix Selection" })
      map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
    end,
  },
}

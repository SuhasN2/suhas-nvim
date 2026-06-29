return {
    -- ==========================================
    -- 1. LOCAL GHOST TEXT (RTX 4060 Ti )
    -- ==========================================
    {
        "milanglacier/minuet-ai.nvim",
        config = function()
            require("minuet").setup({
                -- Switch from chat simulation to native Fill-In-The-Middle
                provider = "openai_fim_compatible",
                provider_options = {
                    openai_fim_compatible = {
                        model = "qwen2.5-coder:7b-base", -- Swap to base variant for pure code completion
                        end_point = "http://localhost:11434/v1/completions", -- Pure text engine endpoint
                        api_key = "TERM",
                        name = "Ollama",
                        stream = true,
                        optional = {
                            stop = { "<|endoftext|>", "<|file_separator|>", "\n\n" },
                            max_tokens = 128,
                        },
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
            local openrouter_adapter = require("codecompanion.adapters").extend("openai", {
                url = "https://openrouter.ai/api/v1/chat/completions",
                env = {
                    -- Pulling key safely from environment to prevent future leaks
                    api_key = os.getenv("OPENROUTER_API_KEY"),
                },
                headers = {
                    ["HTTP-Referer"] = "https://github.com/olimorris/codecompanion.nvim",
                    ["X-Title"] = "Suhas-Nvim",
                },
                schema = {
                    model = {
                        default = "qwen/qwen3-vl-30b-a3b-thinking",
                    },
                    -- Great catch here; keeping stream false protects against thinking chunk crashes
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
            map("v", "<leader>af", "<cmd>CodeCompanion Fix the scode using #buffer as context<cr>", { desc = "AI Fix Selection" })
            map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions" })
        end,
    }
}

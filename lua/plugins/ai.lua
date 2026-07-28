return {
    -- ==========================================
    -- 1. LOCAL GHOST TEXT with OLLAMA 
    -- ==========================================
    {
        "milanglacier/minuet-ai.nvim",
        config = function()
            require("minuet").setup({
                provider = "openai_fim_compatible",
                provider_options = {
                    openai_fim_compatible = {
                        model = "qwen2.5-coder:7b-base",
                        end_point = "http://localhost:11434/v1/completions",
                        api_key = "TERM",
                        name = "Ollama",
                        stream = true,
                        optional = {
                            stop = { "<|endoftext|>", "<|file_separator|>", "\n\n" },
                            max_tokens = 128,
                            temperature = 0.2,
                        },
                    },
                },
                virtualtext = {
                    auto_trigger_ft = { "python", "rust", "c", "cpp", "go", "lua" },
                    keymap = {
                        accept = "<C-g>",
                        accept_line = "<Tab>",
                        dismiss = "<A-e>",
                        next = "<A-]>",
                        prev = "<A-[>",
                    },
                },
            })
        end,
    },
    -- ==========================================
    -- 2. SMART CHAT (OpenRouter Dual-Tier)
    -- ==========================================
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = { adapter = "openrouter_flash" },
                    inline = { adapter = "openrouter_flash" },
                },
                adapters = {
                    http = {
                        openrouter_flash = function()
                            return require("codecompanion.adapters").extend("openai_compatible", {
                                name = "openrouter_flash",
                                env = {
                                    url = "https://openrouter.ai/api",
                                    api_key = "OPENROUTER_API_KEY",
                                    chat_url = "/v1/chat/completions",
                                },
                                headers = {
                                    ["HTTP-Referer"] = "https://github.com/olimorris/codecompanion.nvim",
                                    ["X-Title"] = "Suhas-Nvim",
                                },
                                schema = {
                                    model = {
                                        default = "deepseek/deepseek-v4-flash",
                                    },
                                    stream = { default = false },
                                },
                            })
                        end,

                        openrouter_pro = function()
                            return require("codecompanion.adapters").extend("openai_compatible", {
                                name = "openrouter_pro",
                                env = {
                                    url = "https://openrouter.ai/api",
                                    api_key = "OPENROUTER_API_KEY",
                                    chat_url = "/v1/chat/completions",
                                },
                                headers = {
                                    ["HTTP-Referer"] = "https://github.com/olimorris/codecompanion.nvim",
                                    ["X-Title"] = "Suhas-Nvim",
                                },
                                schema = {
                                    model = {
                                        default = "deepseek/deepseek-v4-pro",
                                    },
                                    stream = { default = false },
                                },
                            })
                        end,
                    },
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

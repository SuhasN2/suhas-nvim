return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = {
        "ts_ls",
        "html",
        "lua_ls",
        "pylsp",
        "clangd",
        "omnisharp",
        "marksman",
        "rust_analyzer",
        "gopls",
        "bashls",
        "jsonls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- List of servers to configure
      local servers = {
        "ts_ls",
        "html",
        "lua_ls",
        "pylsp",
        "clangd",
        "omnisharp",
        "marksman",
        "rust_analyzer",
        "gopls",
        "bashls",
        "jsonls",
      }

      -- Modern setup pattern to avoid the 'lspconfig' deprecation warning
      for _, lsp in ipairs(servers) do
        if vim.lsp.config then
          -- Neovim 0.11+ approach
          vim.lsp.config(lsp, {
            capabilities = capabilities,
          })
        else
          -- Fallback for older versions
          require("lspconfig")[lsp].setup({
            capabilities = capabilities,
          })
        end
      end

      -- LSP Keybindings
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "LSP References" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
    end,
  },
}


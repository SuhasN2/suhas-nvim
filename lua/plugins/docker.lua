
-- Docker Keymaps
local map = vim.keymap.set
map("n", "<leader>dc", "<cmd>term docker-compose up<CR>", { desc = "Docker Compose Up" })
map("n", "<leader>dp", "<cmd>term docker ps<CR>", { desc = "Docker PS" })
map("n", "<leader>ld", "<cmd>term lazydocker<CR>", { desc = "LazyDocker" })




return {
  -- Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "dockerfile", "yaml" })
      end
    end,
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },
}


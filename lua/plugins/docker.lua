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

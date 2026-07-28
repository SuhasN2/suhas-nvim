return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diff View" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true, -- Enables finer line-highlighting
        use_icons = true,
      })
    end,
  },
}

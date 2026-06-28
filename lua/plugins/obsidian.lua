return {
  "epwalsh/obsidian.nvim",
  version = "*", -- Use the latest release
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/main/notes", -- Change this to your actual vault path
      },
   },
    -- Optional: define how new notes are created
    notes_subdir = "00 Zettelkasten",
    new_notes_location = "notes_subdir",

    -- Optional: configure daily notes
    daily_notes = {
      folder = "01  Diary",
      date_format = "%Y-%m-%d",
    },

    -- Completion settings
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- UI settings (requires a Nerd Font)
    ui = {
      enable = true, 
    },
  },
  keys = {
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New Obsidian Note" },
    { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Search Obsidian" },
    { "<leader>nt", "<cmd>ObsidianToday<cr>", desc = "Today's Daily Note" },
    { "<leader>np", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian App" },
    { "<leader>nf", "<cmd>ObsidianFollowLink<cr>", desc = "Follow Link" },
  },
}

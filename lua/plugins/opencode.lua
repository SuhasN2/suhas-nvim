return {
  "sudo-tee/opencode.nvim",
  version = "*", -- Ensures you have the stable 2026 features
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", -- Used for selecting sessions/files
  },
  config = function()
    local opencode = require("opencode")

    opencode.setup({
      -- Points to your 'opencode' binary installed via Homebrew/NPM
      opencode_executable = "opencode",
      
      -- Setting this to true allows OpenCode to show you 
      -- ghost text previews of its suggested changes.
      ghost_text = true,
    })

    -- ==========================================
    -- FRIENDLY KEYMAPS
    -- ==========================================
    local map = vim.keymap.set

    -- 1. CHAT & INPUT
    map("n", "<leader>og", "<cmd>Opencode<cr>", { desc = "AI: Toggle OpenCode Chat" })
    map("n", "<leader>oi", "<cmd>Opencode open input<cr>", { desc = "AI: Prompt Agent" })
    
    -- 2. CONTEXT (The "Send" powers)
    -- Sends your current file to the agent so it can "see" your code
    map("n", "<leader>os", "<cmd>Opencode session select<cr>", { desc = "AI: Send file/Select Session" })
    
    -- 3. APPLYING CHANGES
    -- If the agent suggests a fix, use this to see the diff
    map("n", "<leader>od", "<cmd>Opencode diff open<cr>", { desc = "AI: View Changes (Diff)" })
    map("n", "<leader>oc", "<cmd>Opencode diff close<cr>", { desc = "AI: Close Diff View" })
    
    -- 4. UTILITY
    map("n", "<leader>oo", "<cmd>Opencode open output<cr>", { desc = "AI: Show Agent Logs" })
    map("n", "<leader>or", "<cmd>Opencode session rename<cr>", { desc = "AI: Rename Chat Session" })
  end,
}

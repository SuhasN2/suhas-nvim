return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        --auto_install = true,
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", 
                            "json", "python", "csv", "css", "markdown_inline","rust","go", "bash", "cpp", "cuda","regex", "sql", "tmux", "xml", "yaml", "zig"},
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}

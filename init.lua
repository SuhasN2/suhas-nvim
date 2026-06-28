local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

-- Docker Keymaps
local map = vim.keymap.set
map("n", "<leader>dc", "<cmd>term docker-compose up<CR>", { desc = "Docker Compose Up" })
map("n", "<leader>dp", "<cmd>term docker ps<CR>", { desc = "Docker PS" })
map("n", "<leader>ld", "<cmd>term lazydocker<CR>", { desc = "LazyDocker" })

vim.g.mapleader = " " -- Sets leader to Spacebar

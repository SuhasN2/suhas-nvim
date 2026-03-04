return { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000, config = function()
       require("catppuccin").setup {
           flavour = "mocha",
           color_overrides = {
               mocha = {
                   base = "#000000",
                   mantle = "#212862",
                   crust = "#c8c8c8"
               },
           },
       }
       vim.cmd.colorscheme "catppuccin" end }
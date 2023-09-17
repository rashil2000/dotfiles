return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars
        floats = "transparent", -- style for floating windows
      },
      day_brightness = 0.2,
    },
    -- keymap for toggling theme on the fly
    keys = {
      {
        "<leader>ts",
        function()
          if vim.o.background == "dark" then
            vim.cmd("set bg=light")
          else
            vim.cmd("set bg=dark")
          end
        end,
        desc = "Toggle theme",
      },
    },
  },
}

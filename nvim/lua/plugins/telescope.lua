return {
  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add file browser
  {
    "telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          file_browser = {
            hidden = { file_browser = true, folder_browser = true },
            grouped = true,
            follow_symlinks = true,
          },
        },
      })
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<leader>fo", "<cmd>Telescope file_browser<cr>", desc = "Open file/folder" },
    },
  },
}

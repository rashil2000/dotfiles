return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "c",
        "rust",
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "clangd",
        "rust-analyzer",
        "powershell-editor-services",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
    },
  },
}

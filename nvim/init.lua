local vim = vim
local o = vim.opt
o.list = true
o.ruler = true
o.number = true
o.cursorline = true
-- o.cursorcolumn = true
o.title = true
o.mouse = "a"               -- Enable mouse in all modes (hold shift to disable)
o.mousemoveevent = true     -- receive <MouseMove> without clicks
o.tabstop = 2               -- The width of a TAB (\t) is set to 2
o.shiftwidth = 2            -- Indents will have a width of 2
o.softtabstop = 2           -- Sets the number of columns for TAB
o.expandtab = true          -- Expand TABs to spaces
o.ignorecase = true
o.smartcase = true          -- Ignore case only when the pattern contains no capital letters
o.secure = true
o.exrc = true               -- Project-specific settings
o.termguicolors = true      -- Enable 24-bit RGB colors
o.foldmethod = "syntax"
o.foldenable = true
o.foldlevel = 99            -- Keep almost everything open
o.foldlevelstart = 99       -- On buffer open, show folds expanded
o.wildmode = {
    "lastused",
    "full"
}                          -- Command-line completion mode

-- Tags completion
vim.g.closetag_filenames = "*.html,*.xhtml,*.xml,*.js,*.html.erb,*.md"

-- Set up key mappings
local k = vim.keymap

-- Use ctrl+hjkl to resize windows
k.set("n", "<C-j>", ":resize -2<CR>")
k.set("n", "<C-k>", ":resize +2<CR>")
k.set("n", "<C-h>", ":vertical resize -2<CR>")
k.set("n", "<C-l>", ":vertical resize +2<CR>")

-- Use alt+hjkl to move between split/vsplit panels
k.set("n", "<A-h>", "<C-w>h")
k.set("n", "<A-j>", "<C-w>j")
k.set("n", "<A-k>", "<C-w>k")
k.set("n", "<A-l>", "<C-w>l")

-- Better tabbing
k.set("v", "<", "<gv")
k.set("v", ">", ">gv")

-- Faster buffer navigation
k.set("n", "<F4>", function() vim.cmd("bnext") end, { silent = true })
k.set("t", "<F4>", function() vim.cmd("normal! <C-\\><C-n>") vim.cmd("bnext") end, { silent = true })
k.set("n", "<F3>", function() vim.cmd("bprev") end, { silent = true })
k.set("t", "<F3>", function() vim.cmd("normal! <C-\\><C-n>") vim.cmd("bprev") end, { silent = true })

-- Swap functionality of ctrl-r and r
k.set("n", "r", "<C-r>")
k.set("n", "<C-r>", "r")

-- Toggle line wrap
k.set("n", "<A-z>", function() 
  vim.opt.wrap = not vim.opt.wrap:get()
end, { silent = true })

-- Change working directory
k.set("n", "<Leader>cd", function()
  local dir = vim.fn.expand("%:p:h")
  vim.cmd("cd " .. dir)
  print("Working directory: " .. vim.fn.getcwd())
end, { silent = true })

-- Toggle theme
k.set("n", "<Leader>ts", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { silent = true })

-- Save current file with elevated permissions
if vim.fn.has("win32") == 1 then
  vim.api.nvim_create_user_command("W", function()
    vim.cmd("silent! write !gsudo busybox tee % > nul")
    vim.cmd("edit!")
  end, {})
else
  vim.api.nvim_create_user_command("W", function()
    vim.cmd("silent! write ! sudo         tee % >/dev/null")
    vim.cmd("edit!")
  end, {})
end

-- Plugins
vim.pack.add({
    "https://github.com/github/copilot.vim",
    "https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/catppuccin/nvim",
    "https://github.com/akinsho/bufferline.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",
})

-- Copilot settings
vim.g.copilot_filetypes = { ['*'] = false }
local function copilot_toggle_buffer()
  -- when true, this overrides the global g:copilot_filetypes blacklist
  if vim.b.copilot_enabled then
    vim.b.copilot_enabled = false
    vim.schedule(function() vim.notify("Copilot: disabled for this buffer") end)
  else
    vim.b.copilot_enabled = true
    -- if Copilot was globally disabled via :Copilot disable, ensure it’s running:
    pcall(vim.cmd, "Copilot enable")
    vim.schedule(function() vim.notify("Copilot: enabled for this buffer") end)
  end
end
k.set("n", "<leader>cp", copilot_toggle_buffer, { desc = "Toggle Copilot (buffer)" })

-- File explorer settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()
k.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Colorscheme settings
require("catppuccin").setup({
    transparent_background = true,
    integrations = {
      copilot_vim = true,
    }
})
require("bufferline").setup {
    highlights = require("catppuccin.special.bufferline").get_theme(),
    options = {
        hover = {
            enabled = true,
            delay = 100,
            reveal = {'close'}
        },
    }
}
require('lualine').setup {
    options = {
        theme = "catppuccin"
    }
}
vim.cmd.colorscheme "catppuccin"

-- Sync clipboard between Terminal and Neovim.
-- Function to set OSC 52 clipboard. This function only executes on remote sessions
-- so if we want to paste from home to remote, we need to use the terminal's paste functionality
local function set_osc52_clipboard()
  local function my_paste()
    local content = vim.fn.getreg '"'
    return vim.split(content, '\n')
  end

  local vimosc = require('vim.ui.clipboard.osc52')

  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = vimosc.copy '+',
      ['*'] = vimosc.copy '*',
    },
    paste = {
      ['+'] = my_paste,
      ['*'] = my_paste,
    },
  }
end

-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard:append 'unnamedplus'

  -- Standard SSH session handling or
  -- if the current session is a remote WezTerm session based on the WezTerm executable
  local wezterm_executable = vim.uv.os_getenv 'WEZTERM_EXECUTABLE'
  if vim.uv.os_getenv 'SSH_CLIENT' ~= nil or vim.uv.os_getenv 'SSH_TTY' ~= nil or (wezterm_executable and wezterm_executable:find('wezterm-mux-server', 1, true)) then
    set_osc52_clipboard()
  end
end)
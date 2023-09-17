-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- Start screen
return {
  -- disable alpha
  { "goolord/alpha-nvim", enabled = false },

  -- enable mini.starter
  {
    "echasnovski/mini.starter",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "VimEnter",
    opts = function()
      local pad = string.rep(" ", 22)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require("mini.starter")
      --stylua: ignore
      local config = {
        evaluate_single = true,
        header = table.concat({
			'                                                             ',
			'  /$$   /$$                     /$$    /$$ /$$               ',
			' | $$$ | $$                    | $$   | $$|__/               ',
			' | $$$$| $$  /$$$$$$   /$$$$$$ | $$   | $$ /$$ /$$$$$$/$$$$  ',
			' | $$ $$ $$ /$$__  $$ /$$__  $$|  $$ / $$/| $$| $$_  $$_  $$ ',
			' | $$  $$$$| $$$$$$$$| $$  \\ $$ \\  $$ $$/ | $$| $$ \\ $$ \\ $$ ',
			' | $$\\  $$$| $$_____/| $$  | $$  \\  $$$/  | $$| $$ | $$ | $$ ',
			' | $$ \\  $$|  $$$$$$$|  $$$$$$/   \\  $/   | $$| $$ | $$ | $$ ',
			' |__/  \\__/ \\_______/ \\______/     \\_/    |__/|__/ |__/ |__/ ',
			'                                                             ',
			'                                                             ',
		}, "\n"),
		footer = table.concat({
			'                                                              ',
			'                                                              ',
			'                                                              ',
			'                 .==::.                .::==.                 ',
			'               .=***-:-++.  _-**-_  .++-:-***=.               ',
			' .+*=*-::::::::*+-/: *=*-/+=-:/\\:-=+\\-*=* :\\-+*::::::::-*=*+. ',
			'  -===::::::::+\\-:.*+-:*/--*+-ΦΦ-+*--\\*:-+*.:-/+::::::::===-  ',
			'                ·====- ..++.:==*\\/*==:.++.. -====·              ',
			'                        ˙-+ΨΨ%--%ΨΨ+-˙                        ',
			'                           \\+*==*+/                           ',
			'                             ˙::˙                             ',
		}, "\n"),
        items = {
          new_section("Open",            "lua require('telescope').extensions.file_browser.file_browser()",                                "Telescope"),
          new_section("Recents",         "Telescope oldfiles",                                                                             "Telescope"),
          new_section("Search text",     "Telescope live_grep",                                                                            "Telescope"),
          new_section("Files",           "lua require('telescope').extensions.file_browser.file_browser({path=vim.fn.stdpath('config')})", "Config"),
          new_section("Plugins",         "Lazy",                                                                                           "Config"),
          new_section("New file",        "ene | startinsert",                                                                              "Built-in"),
          new_section("Quit",            "qa",                                                                                             "Built-in"),
          new_section("Session restore", [[lua require("persistence").load()]],                                                            "Session"),
          -- new_section("Current",         "lua require('telescope.builtin').oldfiles({cwd_only=true})",                                     "Telescope"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
      }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)
    end,
  },
}
